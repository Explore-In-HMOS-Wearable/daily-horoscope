export interface IHoroscope {
  month: string;
  startDay: number;
  sign: string;
  src: string;
  description: string;

}
export class Horoscope {
  public month: string;
  public startDay: number;
  public sign: string;
  public src: string;
  public description: string;

  constructor(
  month: string,
  startDay: number,
  sign: string,
  src: string,
  description: string
  ) {
  this.month = month;
  this.startDay = startDay;
  this.sign = sign;
  this.src = src;
  this.description = description;
}
}
