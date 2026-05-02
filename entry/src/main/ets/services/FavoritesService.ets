import common from '@ohos.app.ability.common'
import { preferences } from '@kit.ArkData'

const STORE: string = 'horoscope_prefs'
const KEY: string = 'favorites'

export async function getFavorites(ctx: common.UIAbilityContext): Promise<string[]> {
  try {
    const store = preferences.getPreferencesSync(ctx, { name: STORE })
    const raw = store.getSync(KEY, '[]') as string
    return JSON.parse(raw) as string[]
  } catch (_) {
    return []
  }
}

export async function toggleFavorite(
  ctx: common.UIAbilityContext,
  sign: string
): Promise<string[]> {
  try {
    const store = preferences.getPreferencesSync(ctx, { name: STORE })
    const raw = store.getSync(KEY, '[]') as string
    const list = JSON.parse(raw) as string[]
    const idx = list.indexOf(sign)
    if (idx === -1) {
      list.push(sign)
    } else {
      list.splice(idx, 1)
    }
    store.putSync(KEY, JSON.stringify(list))
    await store.flush()
    return list
  } catch (_) {
    return []
  }
}
