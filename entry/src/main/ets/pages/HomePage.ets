import { HOROSCOPE_PAGE } from './HoroscopePage';

export const HOME_PAGE = 'HomePage';

@Builder
export function HomePageBuilder() {
  HomePage();
}
@Component
struct HomePage {
  @Consume('NavPathStack') private pageStack: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text('Daily Horoscope App🔮✨')
          .fontWeight(FontWeight.Bolder)
          .fontColor('#FFD73B')
          .fontSize(20)
          .width('75%')
          .margin({bottom:12})
        Text('Enable notifications to see your daily comment each morning!')
          .margin(({left:12, right:12}))
      }.onClick(() => {
        this.pageStack.pushPathByName(HOROSCOPE_PAGE, null);
      })
      .justifyContent(FlexAlign.Center)
      .backgroundImage($r('app.media.stars'), ImageRepeat.X)
      .height('100%')
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}