import { IHoroscope } from '../model/Horoscope'

@Component
export struct HoroscopeComponent {
  @Prop horoscope : IHoroscope = {} as IHoroscope
  build() {
    Column() {
      Image($r(this.horoscope.src))
        .width(80)
        .height(80)
        .margin({top:10})
      Text(this.horoscope.sign)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bolder)
        .margin({top:10, bottom:10})
      Text(this.horoscope.description).fontColor(Color.Black)
        .margin({left:10, right:10})
    }.backgroundImage($r('app.media.bg'))
    .backgroundColor(Color.White)
  }
}
