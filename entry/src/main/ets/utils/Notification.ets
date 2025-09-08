import { reminderAgentManager } from '@kit.BackgroundTasksKit'
import { notificationManager } from '@kit.NotificationKit'
import { wantAgent } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import Logger from './Logger'
import { vibrator } from '@kit.SensorServiceKit'

const TAG = '[HoroscopeReminder]'

export function sendDailyHoroscopeNotification(horoscopeSign: string): void {
  const wantAgentInfo: wantAgent.WantAgentInfo = {
    wants: [
      {
        bundleName: 'com.hmosdemos.dailyhoroscopeapp',
        abilityName: 'EntryAbility',
        parameters: {
          url: 'pages/SwiperPage',
          zodiac: horoscopeSign
        }
      }
    ],
    actionType: wantAgent.OperationType.START_ABILITY,
    requestCode: 0,
    wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
  }

  wantAgent.getWantAgent(wantAgentInfo, async (_err: BusinessError) => {
    const reminder: reminderAgentManager.ReminderRequestAlarm = {
      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM,
      hour: 14,
      minute: 42,
      daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
      actionButton: [
        {
          title: 'Close',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        }
      ],
      wantAgent: {
        pkgName: wantAgentInfo?.wants[0]?.bundleName ?? '',
        abilityName: wantAgentInfo?.wants[0]?.abilityName ?? ''
      },
      ringDuration: 10,
      title: '🔮 Daily Horoscope',
      content: `Dear ${horoscopeSign}, your daily comment is ready!`,
      notificationId: 2024,
      slotType: notificationManager.SlotType.SERVICE_INFORMATION
    }

    try {
      const reminderId = await reminderAgentManager.publishReminder(reminder)
      Logger.info(TAG, `Reminder scheduled with ID: ${reminderId}`)
      try {
        if (reminderId) {
          await vibrator.startVibration({ type: 'time', duration: 2000 }, { usage: 'physicalFeedback' })
          Logger.info('Vibration started')
        }
      } catch (err) {
        Logger.error(err, 'while vibration')
      }
    } catch (err) {
      Logger.error(TAG, `Failed to publish reminder: ${err.message}`)
    }
  })
}