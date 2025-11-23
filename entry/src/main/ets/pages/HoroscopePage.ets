import calculateHoroscope from '../utils/Utils';
import { IHoroscope } from '../model/Horoscope';
import { sendDailyHoroscopeNotification } from '../utils/Notification';

@Entry
@Component
export struct HoroscopePage {
  @State months: Array<string> = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December'
  ];
  @State selectedMonth: string = 'January';
  @State selectedDay: number = 1;
  @State days: Array<number> = this.getDaysInMonth('January');
  @State yourHoroscope:IHoroscope = {} as IHoroscope

  getDaysInMonth(month: string): Array<number> {
    const monthIndex = this.months.indexOf(month);
    const year = new Date().getFullYear();
    const daysInMonth = new Date(year, monthIndex + 1, 0).getDate();

    const daysArray: Array<number> = [];
    for (let i = 1; i <= daysInMonth; i++) {
      daysArray.push(i);
    }
    return daysArray;
  }

  build() {
    Column() {
      Text('✨How was the sky when you were born✨').fontWeight(FontWeight.Bolder).fontColor(Color.White).fontSize(16).width('75%')
      Row() {
        Select(this.months.map(month => {
          return {
            value: month
          } as SelectOption;
        }))
          .margin({ right: 4})
          .optionWidth(100)
          .font({size:16})
          .optionFont({size:12})
          .selectedOptionBgColor(Color.Gray)
          .selectedOptionFontColor('#FFD73B')
          .selectedOptionFont({size:16})
          .value(this.selectedMonth)
          .onSelect((index: number) => {
            this.selectedMonth = this.months[index];
            this.days = this.getDaysInMonth(this.selectedMonth);

            if (this.selectedDay > this.days.length) {
              this.selectedDay = 1;
            }

            calculateHoroscope(this.selectedDay, this.selectedMonth).then((result: IHoroscope) => {
              this.yourHoroscope = result;
            });
          });

        Select(this.days.map(day => {
          return {
            value: day.toString()
          } as SelectOption;
        }))
          .value(this.selectedDay.toString())
          .optionWidth(100)
          .optionFont({size:12})
          .font({size:16})
          .selectedOptionBgColor(Color.Gray)
          .selectedOptionFontColor('#FFD73B')
          .onSelect((index: number) => {
            this.selectedDay = this.days[index];
            calculateHoroscope(this.selectedDay, this.selectedMonth).then((result: IHoroscope) => {
              this.yourHoroscope = result;
            });
          });

      }.margin({ top: 20, bottom: 20 })
      .alignItems(VerticalAlign.Center)

      if (this.yourHoroscope.sign !== undefined ) {
        Text('You are:')
          .margin({ bottom: 5 })
        Text('✨' + this.yourHoroscope.sign + '✨')
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .onClick(async () => {
            AppStorage.setOrCreate('zodiac', this.yourHoroscope.sign);
            sendDailyHoroscopeNotification(this.yourHoroscope.sign);
            this.getUIContext().getRouter().pushUrl({
              url:'pages/SwiperPage',
              params: this.yourHoroscope
            })
          })
      }

    }
    .backgroundImage($r('app.media.stars'), ImageRepeat.X)
    .height('100%')
    .width('100%')
    .padding(20);

  }
}

