const REF_MS: number = 947182440000
const CYCLE: number = 29.53058867

function getLunarAge(): number {
  const age = ((Date.now() - REF_MS) / 86400000) % CYCLE
  return age < 0 ? age + CYCLE : age
}

export function getCurrentMoonEmoji(): string {
  const a = getLunarAge()
  const s = CYCLE / 8
  if (a < s * 0.5) {
    return '🌑'
  }
  if (a < s * 1.5) {
    return '🌒'
  }
  if (a < s * 2.5) {
    return '🌓'
  }
  if (a < s * 3.5) {
    return '🌔'
  }
  if (a < s * 4.5) {
    return '🌕'
  }
  if (a < s * 5.5) {
    return '🌖'
  }
  if (a < s * 6.5) {
    return '🌗'
  }
  return '🌘'
}

export function getCurrentMoonName(): string {
  const a = getLunarAge()
  const s = CYCLE / 8
  if (a < s * 0.5) {
    return 'New Moon'
  }
  if (a < s * 1.5) {
    return 'Waxing Crescent'
  }
  if (a < s * 2.5) {
    return 'First Quarter'
  }
  if (a < s * 3.5) {
    return 'Waxing Gibbous'
  }
  if (a < s * 4.5) {
    return 'Full Moon'
  }
  if (a < s * 5.5) {
    return 'Waning Gibbous'
  }
  if (a < s * 6.5) {
    return 'Last Quarter'
  }
  return 'Waning Crescent'
}

export function getMoonMeaning(): string {
  const a = getLunarAge()
  const s = CYCLE / 8
  if (a < s * 0.5) {
    return 'New beginnings'
  }
  if (a < s * 1.5) {
    return 'Set intentions'
  }
  if (a < s * 2.5) {
    return 'Push forward'
  }
  if (a < s * 3.5) {
    return 'Refine your goals'
  }
  if (a < s * 4.5) {
    return 'Harvest & celebrate'
  }
  if (a < s * 5.5) {
    return 'Give gratitude'
  }
  if (a < s * 6.5) {
    return 'Release & let go'
  }
  return 'Rest & reflect'
}
