import { HoroscopeComponent } from '../components/HoroscopeComponent';
import { IHoroscope } from '../model/Horoscope';
import { HoroscopeViewModel } from '../viewmodel/HoroscopeViewModel';
import router from '@ohos.router';

@Entry
@Component
export struct SwiperPage {
  private viewModel: HoroscopeViewModel = new HoroscopeViewModel()
  @State horoscopeList: IHoroscope[] = []
  @State currentIndex: number = 0
  horoscope: IHoroscope = {} as IHoroscope;

  aboutToAppear(): void {
    const horoscopeParams = router.getParams() as IHoroscope
    this.horoscope = horoscopeParams

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
    Swiper() {
      ForEach(this.horoscopeList, (zodiac: IHoroscope, index: number) => {
        HoroscopeComponent({ horoscope: zodiac })
      }, (zodiac: IHoroscope, index: number) => `${index}${zodiac.sign}` )
    }
    .index(this.currentIndex)
    .height('100%')
    .width('100%')
  }
}
