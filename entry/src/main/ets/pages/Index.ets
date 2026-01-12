import { getPermission } from '../utils/Utils'
import common from '@ohos.app.ability.common'
import { HomePageBuilder, HOME_PAGE } from './HomePage';
import { HoroscopePageBuilder, HOROSCOPE_PAGE } from './HoroscopePage';
import { SwiperPageBuilder, SWIPER_PAGE } from './SwiperPage';

@Entry
@Component
struct Index {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  @Builder
  PageMap(name: string) {
    if (name === HOME_PAGE) {
      HomePageBuilder();
    } else if (name === HOROSCOPE_PAGE) {
      HoroscopePageBuilder()
    } else if (name === SWIPER_PAGE) {
      SwiperPageBuilder()
    }
  }

  aboutToAppear(): void {
    getPermission(this.getUIContext().getHostContext() as common.UIAbilityContext)
  }

  build() {
    Navigation(this.pageStack) {
    }
    .onAppear(() => {
      this.pageStack.pushPathByName(HOME_PAGE, null, false);
    })
    .width('100%')
    .height('100%')
    .hideNavBar(true)
    .hideTitleBar(true)
    .hideBackButton(true)
    .ignoreLayoutSafeArea()
    .navDestination(this.PageMap)
  }
}