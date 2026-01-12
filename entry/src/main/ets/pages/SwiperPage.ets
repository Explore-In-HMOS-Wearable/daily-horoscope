import { HoroscopeComponent } from '../components/HoroscopeComponent';
import { IHoroscope } from '../model/Horoscope';
import { HoroscopeViewModel } from '../viewmodel/HoroscopeViewModel';

export const SWIPER_PAGE = 'SwiperPage';

@Builder
export function SwiperPageBuilder() {
  SwiperPage();
}

@Component
export struct SwiperPage {
  private viewModel: HoroscopeViewModel = new HoroscopeViewModel()
  @State horoscopeList: IHoroscope[] = []
  @State currentIndex: number = 0
  horoscope: IHoroscope = {} as IHoroscope;

  private handlePageParams(params: IHoroscope) {
    this.horoscope = params
    this.viewModel.listHoroscopes().then((result: IHoroscope[]) => {
      this.horoscopeList = result

      const foundIndex = result.findIndex(
        h => h.sign === this.horoscope.sign
      )
      if (foundIndex !== -1) {
        this.currentIndex = foundIndex
      }
    })
  }

  build() {
    NavDestination() {
      Swiper() {
        ForEach(this.horoscopeList, (zodiac: IHoroscope) => {
          HoroscopeComponent({ horoscope: zodiac })
        }, (zodiac: IHoroscope) => `${zodiac.sign}`)
      }
      .index(this.currentIndex)
      .height('100%')
      .width('100%')
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
