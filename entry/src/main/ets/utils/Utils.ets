import { IHoroscope } from '../model/Horoscope';
import { HoroscopeViewModel } from '../viewmodel/HoroscopeViewModel';
import { common } from '@kit.AbilityKit';
import { notificationManager } from '@kit.NotificationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from './Logger';

const TAG: string = '[PublishOperation]';

export default async function calculateHoroscope(selectedDay: number, selectedMonth: string): Promise<IHoroscope> {
  const viewModel: HoroscopeViewModel = new HoroscopeViewModel()
  const horoscopeList: IHoroscope[] = await viewModel.listHoroscopes()

  for (let i = 0; i < horoscopeList.length - 1; i++) {
    const current: IHoroscope = horoscopeList[i] as IHoroscope;
    const next: IHoroscope = horoscopeList[i + 1] as IHoroscope;

    if (selectedMonth === current.month && selectedDay >= current.startDay) {
      Logger.info(current.sign, 'is the horoscope')
      return current;
    }

    if (selectedMonth === next.month && selectedDay < next.startDay) {
      Logger.info(current.sign, 'is the horoscope')
      return current;
    }
  }

  return {} as IHoroscope;
}

export async function getPermission(context: common.UIAbilityContext): Promise<void> {
  notificationManager.isNotificationEnabled().then((data: boolean) => {
    if (!data) {
      notificationManager.requestEnableNotification(context).then(() => {
        Logger.info( TAG, `[ANS] requestEnableNotification success`);
      }).catch((err : BusinessError) => {
        if (1600004 === err.code) {
          Logger.error( TAG, `[ANS] requestEnableNotification refused, code is ${err.code}, message is ${err.message}`);
        } else {
          Logger.error( TAG, `[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
        }
      });
    }
  }).catch((err : BusinessError) => {
    Logger.error( TAG, `isNotificationEnabled fail, code is ${err.code}, message is ${err.message}`);
  });
}

