import { HoroscopeComponent } from '../components/HoroscopeComponent'
import { IHoroscope } from '../model/Horoscope'
import { HoroscopeViewModel } from '../viewmodel/HoroscopeViewModel'
import { getFavorites, toggleFavorite } from '../services/FavoritesService'
import { getZodiacMeta, ZodiacMeta } from '../model/ZodiacMeta'
import { getDailyTarot, TarotCard } from '../model/TarotDeck'
import vibrator from '@ohos.vibrator'
import common from '@ohos.app.ability.common'
import { getHeartRateLabel, HeartRateViewModel } from '../viewmodel/HeartRateViewModel'

export const SWIPER_PAGE = 'SwiperPage'

@Builder
export function SwiperPageBuilder() {
  SwiperPage()
}

@Component
export struct SwiperPage {
  @Consume('NavPathStack') private pageStack: NavPathStack;
  private viewModel: HoroscopeViewModel = new HoroscopeViewModel()
  @State horoscopeList: IHoroscope[] = []
  @State displayList: IHoroscope[] = []
  @State currentIndex: number = 0
  horoscope: IHoroscope = {} as IHoroscope
  @State favorites: string[] = []
  @State showFavOnly: boolean = false
  private ctx: common.UIAbilityContext =
    this.getUIContext().getHostContext() as common.UIAbilityContext
  private tarot: TarotCard = getDailyTarot()
  @State heartRateVM: HeartRateViewModel = new HeartRateViewModel();

  aboutToAppear(): void {
    getFavorites(this.ctx).then((list: string[]) => {
      this.favorites = list
    })
    this.heartRateVM.subscribeToSensors();
  }

  aboutToDisappear(): void {
    this.heartRateVM.unsubscribeFromSensors();
  }

  private updateDisplayList(): void {
    this.displayList = this.showFavOnly
      ? this.horoscopeList.filter(h => this.favorites.includes(h.sign))
      : this.horoscopeList.slice()
  }

  private async onStarTap(sign: string): Promise<void> {
    try {
      vibrator.startVibration({ type: 'time', duration: 60 }, { id: 0, usage: 'touch' })
    } catch (_) {
    }
    this.favorites = await toggleFavorite(this.ctx, sign)
    this.updateDisplayList()
  }

  private onFilterTap(): void {
    if (!this.showFavOnly && this.favorites.length === 0) {
      return
    }
    this.showFavOnly = !this.showFavOnly
    this.currentIndex = 0
    this.updateDisplayList()
  }

  private handlePageParams(params: IHoroscope): void {
    this.horoscope = params
    this.viewModel.listHoroscopes().then((result: IHoroscope[]) => {
      this.horoscopeList = result
      this.updateDisplayList()
      const idx = result.findIndex(h => h.sign === this.horoscope.sign)
      if (idx !== -1) {
        this.currentIndex = idx
      }
    })
  }

  build() {
    NavDestination() {
      Stack() {
        if (this.showFavOnly && this.displayList.length === 0) {
          Column({ space: 12 }) {
            Text('☆').fontSize(44).fontColor('#FFFFFF')
            Text('No favourites yet')
              .fontSize(14).fontColor('#FFFFFF').fontWeight(FontWeight.Medium)
            Text('Tap ★ on a sign to save it')
              .fontSize(11).fontColor('#CCCCCC')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#000000')

        } else {
          Swiper() {
            ForEach(this.displayList, (zodiac: IHoroscope) => {
              Stack() {
                Image($r('app.media.bg'))
                  .margin(15)
                  .width('100%')
                  .height('100%')
                  .objectFit(ImageFit.Cover)

                HoroscopeComponent({ horoscope: zodiac })
                  .width('100%')
                  .height('100%')

                Row() {
                  SymbolGlyph($r('sys.symbol.arrow_left'))
                    .fontSize(16)
                    .fontColor([Color.Black])
                    .onClick(() => {
                      this.pageStack.pop()
                    })

                  Text(this.favorites.includes(zodiac.sign) ? '★' : '☆')
                    .fontSize(16)
                    .fontColor(this.favorites.includes(zodiac.sign) ? '#FFD73B' : '#DDDDDD')
                    .width(36)
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .backgroundColor('#66000000')
                    .borderRadius(22)
                    .onClick(() => this.onStarTap(zodiac.sign))
                }.width('100%')
                .padding({ left: 20, right: 20 })
                .position({ y: 50 })
                .justifyContent(FlexAlign.SpaceBetween)

                Column({ space: 2 }) {
                  if (getZodiacMeta(zodiac.sign) !== undefined) {
                    Row({ space: 10 }) {
                      Row({ space: 4 }) {
                        Text((getZodiacMeta(zodiac.sign) as ZodiacMeta).elementEmoji)
                          .fontSize(10)
                        Text((getZodiacMeta(zodiac.sign) as ZodiacMeta).element)
                          .fontSize(10)
                          .fontColor((getZodiacMeta(zodiac.sign) as ZodiacMeta).elementColor)
                          .fontWeight(FontWeight.Medium)
                      }
                      Row({ space: 4 }) {
                        Text('💞').fontSize(10)
                        Text((getZodiacMeta(zodiac.sign) as ZodiacMeta).bestMatch)
                          .fontSize(10)
                          .fontColor('#CE93D8')
                      }
                    }
                    .justifyContent(FlexAlign.Center)
                    .width('100%')
                  }

                  Row({ space: 6 }) {
                    Text(this.tarot.emoji).fontSize(10)
                    Text(this.tarot.name)
                      .fontSize(10)
                      .fontColor('#FFD54F')
                      .fontWeight(FontWeight.Medium)
                    Text('·').fontSize(11).fontColor('#888888')
                    Text(this.tarot.message)
                      .fontSize(10)
                      .fontColor('#DDDDDD')
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .layoutWeight(1)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Center)

                  Row({ space: 6 }) {
                    Text('💓').fontSize(12)
                    Text(`${this.heartRateVM.heartRateData !== -1 ? `${this.heartRateVM.heartRateData}` : '0'} bpm`)
                      .fontSize(11)
                      .fontColor('#FF6B6B')
                      .fontWeight(FontWeight.Bold)
                    Text('·').fontSize(11).fontColor('#888888')
                    Text(getHeartRateLabel(this.heartRateVM.heartRateData !== -1 ? this.heartRateVM.heartRateData : 0))
                      .fontSize(11)
                      .fontColor('#DDDDDD')
                  }
                  .justifyContent(FlexAlign.Center)
                  .width('100%')
                }
                .width('100%')
                .height('32%')
                .padding({ left: 28, right: 28, top: 6 })
                .backgroundColor('#CC000000')
                .position({ x: 2, y: '72%' })

              }
              .width('100%')
              .height('100%')

            }, (zodiac: IHoroscope) => zodiac.sign)
          }
          .index(this.currentIndex)
          .width('100%')
          .height('100%')
          .indicator(
            new DotIndicator()
              .color('#66FFFFFF')
              .selectedColor('#FFFFFF')
              .itemWidth(6)
              .itemHeight(6)
              .selectedItemWidth(14)
              .selectedItemHeight(6)
          )

        }

        Row({ space: 6 }) {
          Text(this.showFavOnly ? '★ Favourites' : '✦ All Signs')
            .fontSize(10)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)

          if (this.favorites.length > 0 || this.showFavOnly) {
            Text(this.showFavOnly ? 'Show All' : '★ Filter')
              .fontSize(10)
              .fontColor('#FFD73B')
              .padding({
                left: 8,
                right: 8,
                top: 5,
                bottom: 2
              })
              .backgroundColor('#66000000')
              .borderRadius(8)
              .onClick(() => this.onFilterTap())
          }
        }
        .width('100%')
        .height(33)
        .padding({ left: 51, right: 51 })
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#88000000')
        .position({ x: 0, y: 0 })

      }
      .width('100%')
      .height('100%')

    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.handlePageParams(context.pathInfo.param as IHoroscope)
    })
  }
}
