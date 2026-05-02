import calculateHoroscope from '../utils/Utils'
import { IHoroscope } from '../model/Horoscope'
import { sendDailyHoroscopeNotification } from '../utils/Notification'
import { SWIPER_PAGE } from './SwiperPage'
import {
  getCurrentMoonEmoji,
  getCurrentMoonName,
  getMoonMeaning
} from '../utils/MoonPhaseCalculator'
import { recordVisit, StreakData } from '../services/StreakService'
import common from '@ohos.app.ability.common'

export const HOROSCOPE_PAGE = 'HoroscopePage'

@Builder
export function HoroscopePageBuilder() {
  HoroscopePage()
}

@Component
export struct HoroscopePage {
  @Consume('NavPathStack') private pageStack: NavPathStack
  @State months: Array<string> = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December'
  ]
  @State selectedMonth: string = 'January'
  @State selectedDay: number = 1
  @State days: Array<number> = this.getDaysInMonth('January')
  @State yourHoroscope: IHoroscope = {} as IHoroscope

  private moonEmoji: string = getCurrentMoonEmoji()
  private moonName: string = getCurrentMoonName()
  private moonMeaning: string = getMoonMeaning()

  @State streak: StreakData = { current: 0, best: 0, isNewRecord: false }
  private ctx: common.UIAbilityContext =
    this.getUIContext().getHostContext() as common.UIAbilityContext

  getDaysInMonth(month: string): Array<number> {
    const monthIndex = this.months.indexOf(month)
    const year = new Date().getFullYear()
    const daysInMonth = new Date(year, monthIndex + 1, 0).getDate()
    const daysArray: Array<number> = []
    for (let i = 1; i <= daysInMonth; i++) {
      daysArray.push(i)
    }
    return daysArray
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
        }
        .backgroundImage($r('app.media.stars'), ImageRepeat.XY)
        .height('100%')
        .width('100%')
        Scroll() {
          Column() {

            Row({ space: 10 }) {
              Text(this.moonEmoji)
                .fontSize(20)
              Column({ space: 2 }) {
                Text(this.moonName)
                  .fontSize(12)
                  .fontColor('#FFFFFF')
                  .fontWeight(FontWeight.Medium)
                Text(this.moonMeaning)
                  .fontSize(10)
                  .fontColor('#BBBBBB')
                  .fontStyle(FontStyle.Italic)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('80%')
            .padding({ left: 14, right: 14, top: 10, bottom: 10 })
            .backgroundColor('#1A1A2E')
            .borderRadius(12)
            .margin({ bottom: 16 })

            Text('✨How was the sky when you were born✨')
              .fontWeight(FontWeight.Bolder)
              .fontColor(Color.White)
              .fontSize(14)
              .width('75%')

            Row() {
              Select(this.months.map(month => {
                return { value: month } as SelectOption
              }))
                .margin({ right: 4 })
                .optionWidth(100)
                .font({ size: 14 })
                .optionFont({ size: 12 })
                .selectedOptionBgColor(Color.Gray)
                .selectedOptionFontColor('#FFD73B')
                .selectedOptionFont({ size: 16 })
                .value(this.selectedMonth)
                .onSelect((index: number) => {
                  this.selectedMonth = this.months[index]
                  this.days = this.getDaysInMonth(this.selectedMonth)
                  if (this.selectedDay > this.days.length) {
                    this.selectedDay = 1
                  }
                  calculateHoroscope(this.selectedDay, this.selectedMonth).then((result: IHoroscope) => {
                    this.yourHoroscope = result
                  })
                })

              Select(this.days.map(day => {
                return { value: day.toString() } as SelectOption
              }))
                .value(this.selectedDay.toString())
                .optionWidth(100)
                .optionFont({ size: 12 })
                .font({ size: 14 })
                .selectedOptionBgColor(Color.Gray)
                .selectedOptionFontColor('#FFD73B')
                .onSelect((index: number) => {
                  this.selectedDay = this.days[index]
                  calculateHoroscope(this.selectedDay, this.selectedMonth).then((result: IHoroscope) => {
                    this.yourHoroscope = result
                  })
                })
            }
            .margin({ top: 20, bottom: 20 })
            .alignItems(VerticalAlign.Center)

            if (this.yourHoroscope.sign !== undefined) {
              Text('You are:')
                .margin({ bottom: 5 })

              Text(`✨ ${this.yourHoroscope.sign} ✨`)
                .fontWeight(FontWeight.Bold)
                .fontSize(14)
                .onClick(async () => {
                  AppStorage.setOrCreate('zodiac', this.yourHoroscope.sign)
                  sendDailyHoroscopeNotification(this.yourHoroscope.sign)

                  this.streak = await recordVisit(this.ctx)

                  this.pageStack.pushPathByName(SWIPER_PAGE, this.yourHoroscope)
                })

              if (this.streak.current > 0) {
                Column({ space: 4 }) {
                  Row({ space: 6 }) {
                    Text('🔥')
                      .fontSize(12)
                    Text(`${this.streak.current} day streak!`)
                      .fontSize(12)
                      .fontColor('#FFD73B')
                      .fontWeight(FontWeight.Bold)
                  }
                  Row({ space: 4 }) {
                    Text('Best:')
                      .fontSize(10)
                      .fontColor('#AAAAAA')
                    Text(`${this.streak.best} days`)
                      .fontSize(10)
                      .fontColor('#AAAAAA')
                  }
                  if (this.streak.isNewRecord) {
                    Text('🏆 New record!')
                      .fontSize(11)
                      .fontColor('#FFD73B')
                      .fontWeight(FontWeight.Bold)
                  }
                }
                .margin({ top: 12 })
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .backgroundColor('#1A1200')
                .borderRadius(10)
              }
            }

          }
          .padding(20)
        }.height('100%')
        .width('100%')
      }.height('100%')
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}
