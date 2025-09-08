import { router } from '@kit.ArkUI'
import { getPermission } from '../utils/Utils'
import common from '@ohos.app.ability.common'

@Entry
@Component
struct Index {

  aboutToAppear(): void {
    getPermission(this.getUIContext().getHostContext() as common.UIAbilityContext)
  }
  build() {
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
      router.pushUrl({
        url: 'pages/HoroscopePage'
      })
    })
    .justifyContent(FlexAlign.Center)
    .backgroundImage($r('app.media.stars'), ImageRepeat.X)
    .height('100%')
    .width('100%')
  }
}