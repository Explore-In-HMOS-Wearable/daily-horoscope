export interface ZodiacMeta {
  element: string
  elementEmoji: string
  elementColor: string
  bestMatch: string
}

const META: Record<string, ZodiacMeta> = {
  'Aries':       { element: 'Fire',  elementEmoji: '🔥', elementColor: '#FF6B6B', bestMatch: 'Leo' },
  'Taurus':      { element: 'Earth', elementEmoji: '🌿', elementColor: '#66BB6A', bestMatch: 'Virgo' },
  'Gemini':      { element: 'Air',   elementEmoji: '💨', elementColor: '#FFD54F', bestMatch: 'Libra' },
  'Cancer':      { element: 'Water', elementEmoji: '💧', elementColor: '#4FC3F7', bestMatch: 'Scorpio' },
  'Leo':         { element: 'Fire',  elementEmoji: '🔥', elementColor: '#FFA726', bestMatch: 'Aries' },
  'Virgo':       { element: 'Earth', elementEmoji: '🌿', elementColor: '#A5D6A7', bestMatch: 'Taurus' },
  'Libra':       { element: 'Air',   elementEmoji: '💨', elementColor: '#CE93D8', bestMatch: 'Gemini' },
  'Scorpio':     { element: 'Water', elementEmoji: '💧', elementColor: '#7B1FA2', bestMatch: 'Cancer' },
  'Sagittarius': { element: 'Fire',  elementEmoji: '🔥', elementColor: '#FF7043', bestMatch: 'Aries' },
  'Capricorn':   { element: 'Earth', elementEmoji: '🌿', elementColor: '#90A4AE', bestMatch: 'Taurus' },
  'Aquarius':    { element: 'Air',   elementEmoji: '💨', elementColor: '#29B6F6', bestMatch: 'Gemini' },
  'Pisces':      { element: 'Water', elementEmoji: '💧', elementColor: '#4DD0E1', bestMatch: 'Cancer' }
}

export function getZodiacMeta(sign: string): ZodiacMeta | undefined {
  return META[sign]
}
