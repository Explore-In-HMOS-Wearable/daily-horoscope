export interface TarotCard {
  name: string
  emoji: string
  meaning: string
  message: string
}

const DECK: TarotCard[] = [
  { name: 'The Fool',         emoji: '🌟', meaning: 'New beginnings',  message: 'A leap of faith awaits' },
  { name: 'The Magician',     emoji: '✨', meaning: 'Manifestation',   message: 'Your will shapes reality' },
  { name: 'High Priestess',   emoji: '🌙', meaning: 'Intuition',       message: 'Trust your inner voice' },
  { name: 'The Empress',      emoji: '🌸', meaning: 'Abundance',       message: 'Nurture what you love' },
  { name: 'The Emperor',      emoji: '👑', meaning: 'Authority',       message: 'Lead with confidence' },
  { name: 'The Hierophant',   emoji: '📿', meaning: 'Tradition',       message: 'Seek wisdom in others' },
  { name: 'The Lovers',       emoji: '💞', meaning: 'Connection',      message: 'Choose with your heart' },
  { name: 'The Chariot',      emoji: '🏆', meaning: 'Willpower',       message: 'Victory through focus' },
  { name: 'Strength',         emoji: '🦁', meaning: 'Courage',         message: 'Gentle power prevails' },
  { name: 'The Hermit',       emoji: '🕯️', meaning: 'Reflection',      message: 'Solitude brings clarity' },
  { name: 'Wheel of Fortune', emoji: '🎡', meaning: 'Cycles',          message: 'Change is in the air' },
  { name: 'Justice',          emoji: '⚖️', meaning: 'Balance',         message: 'Truth will be revealed' },
  { name: 'The Hanged Man',   emoji: '🔄', meaning: 'Surrender',       message: 'Pause, gain perspective' },
  { name: 'Death',            emoji: '🦋', meaning: 'Transformation',  message: 'Endings bring new life' },
  { name: 'Temperance',       emoji: '⚗️', meaning: 'Moderation',      message: 'Find your middle path' },
  { name: 'The Devil',        emoji: '🔗', meaning: 'Attachment',      message: 'Break free from limits' },
  { name: 'The Tower',        emoji: '⚡', meaning: 'Revelation',      message: 'Sudden change brings truth' },
  { name: 'The Star',         emoji: '⭐', meaning: 'Hope',            message: 'Brighter days ahead' },
  { name: 'The Moon',         emoji: '🌕', meaning: 'Mystery',         message: 'Hidden truths surface' },
  { name: 'The Sun',          emoji: '☀️', meaning: 'Joy',             message: 'Clarity and warmth await' },
  { name: 'Judgement',        emoji: '🎺', meaning: 'Renewal',         message: 'Answer your higher calling' },
  { name: 'The World',        emoji: '🌍', meaning: 'Completion',      message: 'You have come full circle' }
]

export function getDailyTarot(): TarotCard {
  const now = new Date()
  const startOfYear = new Date(now.getFullYear(), 0, 0)
  const dayOfYear = Math.floor((now.getTime() - startOfYear.getTime()) / 86400000)
  return DECK[dayOfYear % DECK.length]
}
