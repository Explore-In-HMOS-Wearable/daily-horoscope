import { IHoroscope } from '../model/Horoscope'

@Component
export struct HoroscopeComponent {
  @Prop horoscope : IHoroscope = {} as IHoroscope
  build() {
    Column() {
      Image($r(this.horoscope.src))
        .width(50)
        .height(50)
        .margin({top:8})
      Text(this.horoscope.sign)
        .fontSize(12)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bolder)
        .margin({top:8, bottom:8})
      Text(this.horoscope.description).fontColor(Color.Black)
        .fontSize(10)
        .margin({left:20, right:20, bottom: 36})
    }.backgroundImage($r('app.media.bg'))
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
