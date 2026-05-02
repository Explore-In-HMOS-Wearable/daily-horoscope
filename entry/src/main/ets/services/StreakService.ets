import common from '@ohos.app.ability.common'
import { preferences } from '@kit.ArkData'

const STORE: string = 'horoscope_prefs'
const KEY_DATE: string = 'streak_date'
const KEY_COUNT: string = 'streak_count'
const KEY_BEST: string = 'streak_best'

export interface StreakData {
  current: number
  best: number
  isNewRecord: boolean
}

export async function recordVisit(ctx: common.UIAbilityContext): Promise<StreakData> {
  try {
    const store = preferences.getPreferencesSync(ctx, { name: STORE })
    const today = new Date().toISOString().split('T')[0]       // 'YYYY-MM-DD'
    const lastDate = store.getSync(KEY_DATE, '') as string
    let count = store.getSync(KEY_COUNT, 0) as number
    let best = store.getSync(KEY_BEST, 0) as number

    if (lastDate === today) {
      return { current: count, best, isNewRecord: false }
    }

    const yesterday = new Date(Date.now() - 86400000).toISOString().split('T')[0]
    count = lastDate === yesterday ? count + 1 : 1   // continue or reset

    const isNewRecord = count > best
    if (isNewRecord) {
      best = count
    }

    store.putSync(KEY_DATE, today)
    store.putSync(KEY_COUNT, count)
    store.putSync(KEY_BEST, best)
    await store.flush()

    return { current: count, best, isNewRecord }
  } catch (_) {
    return { current: 1, best: 1, isNewRecord: false }
  }
}

export async function getStreak(ctx: common.UIAbilityContext): Promise<StreakData> {
  try {
    const store = preferences.getPreferencesSync(ctx, { name: STORE })
    const count = store.getSync(KEY_COUNT, 0) as number
    const best = store.getSync(KEY_BEST, 0) as number
    return { current: count, best, isNewRecord: false }
  } catch (_) {
    return { current: 0, best: 0, isNewRecord: false }
  }
}
