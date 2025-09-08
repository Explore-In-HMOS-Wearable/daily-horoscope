import { Horoscope } from '../model/Horoscope';

export class HoroscopeViewModel {
  async listHoroscopes(): Promise<Horoscope[]> {
    try {
      const allHoroscopes = [
        new Horoscope(
          'January',
          20,
          'Aquarius',
          'app.media.aquarius',
          'Innovative and independent, Aquarians are known for their unique perspective on life. They are forward-thinking and often embrace new technologies. Aquarians value individuality and are often considered visionaries. They care deeply about social causes and humanity.'
        ),
        new Horoscope(
          'February',
          19,
          'Pisces',
          'app.media.pisces',
          'Compassionate and artistic, Pisces are deeply intuitive and emotional beings. They are dreamers drawn to art, poetry, and music. Their empathy is profound, often feeling others’ emotions as their own. Sometimes they need solitude to recharge emotionally.'
        ),
        new Horoscope(
          'March',
          21,
          'Aries',
          'app.media.aries',
          'Bold and ambitious, Aries dive headfirst into life and are natural leaders. They are known for their courage and spontaneity. Aries enjoy competition and are often first to start new ventures. Their impulsive nature can sometimes lead to hasty decisions.'
        ),
        new Horoscope(
          'April',
          20,
          'Taurus',
          'app.media.taurus',
          'Reliable and patient, Taurus individuals value stability and material comforts. They enjoy routine and often seek security in all areas of life. Taurus is deeply loyal and grounded, making them trustworthy companions. They can be stubborn and resistant to change.'
        ),
        new Horoscope(
          'May',
          21,
          'Gemini',
          'app.media.gemini',
          'Witty and curious, Geminis are social butterflies who love intellectual stimulation. They enjoy exploring new ideas and making connections. Their adaptability is their strength, but it can also make them seem inconsistent. Geminis love variety and hate routine.'
        ),
        new Horoscope(
          'June',
          21,
          'Cancer',
          'app.media.cancer',
          'Emotional and nurturing, Cancers are deeply intuitive and protective of loved ones. They value home and family above all. Their sensitivity allows them to care deeply, but also makes them prone to mood swings. They seek emotional security and close bonds.'
        ),
        new Horoscope(
          'July',
          23,
          'Leo',
          'app.media.leo',
          'Confident and charismatic, Leos are natural-born leaders who love being in the spotlight. They radiate warmth and inspire others. Leos enjoy praise and recognition, but also give generously. They can be proud, but they’re also fiercely loyal.'
        ),
        new Horoscope(
          'August',
          23,
          'Virgo',
          'app.media.virgo',
          'Analytical and practical, Virgos are perfectionists who pay attention to detail. They are reliable and strive for efficiency. Virgos often help others quietly and with great care. Their critical eye aims for improvement, not judgment.'
        ),
        new Horoscope(
          'September',
          23,
          'Libra',
          'app.media.libra',
          'Diplomatic and charming, Libras seek balance and harmony in all aspects of life. They are peace-seekers and appreciate beauty. Libras are excellent communicators who value fairness. They sometimes struggle with indecision due to their desire to please everyone.'
        ),
        new Horoscope(
          'October',
          23,
          'Scorpio',
          'app.media.scorpio',
          'Passionate and resourceful, Scorpios are intense and emotionally powerful. They are loyal to a fault and deeply intuitive. Scorpios often hide their emotions behind a calm exterior. Their drive and focus help them achieve anything they commit to.'
        ),
        new Horoscope(
          'November',
          22,
          'Sagittarius',
          'app.media.sagittarius',
          'Adventurous and optimistic, Sagittarians love freedom and exploring new ideas. They are seekers of truth and meaning. Sagittarians are philosophical and open-minded. Their honesty is refreshing, though it can sometimes come off as blunt.'
        ),
        new Horoscope(
          'December',
          22,
          'Capricorn',
          'app.media.capricorn',
          'Disciplined and responsible, Capricorns are goal-oriented and value tradition. They are strategic thinkers who plan carefully. Capricorns climb steadily toward success, rarely giving up. Their practical nature helps them remain grounded.'
        ),
        new Horoscope(
          'January',
          1,
          'Capricorn',
          'app.media.capricorn',
          'Disciplined and responsible, Capricorns are goal-oriented and value tradition. They often carry a mature and serious demeanor from a young age. Capricorns are dependable and persistent, with long-term visions. They respect structure and earned achievements.'
        )
      ];

      const unique = Array.from(
        new Map(
          allHoroscopes.map(h => [
            h.sign,
            new Horoscope(
              h.month,
              h.startDay,
              h.sign,
              h.src,
              h.description.split('.')[0] + '.'
            )
          ])
        ).values()
      );

      return unique;
    } catch (e) {
      return [];
    }
  }
}
