import { heartRateService } from '../services/HeartRateService';
import { sensor } from '@kit.SensorServiceKit';

@Observed
export class HeartRateViewModel {
  @Track
  heartRateData: number = -1

  async subscribeToSensors(): Promise<void> {
    heartRateService.subscribeToHeartRate(
      (data: sensor.HeartRateResponse) => this.handleHeartRateData(data),
      200000000
    );
  }

  unsubscribeFromSensors(): void {
    heartRateService.unsubscribeFromHeartRate();
  }

  private handleHeartRateData(data: sensor.HeartRateResponse): void {
    if (data.heartRate === 255) {
      this.heartRateData = 0
    } else {
      this.heartRateData = data.heartRate
    }

  }

  getHeartRate(): number {
    return this.heartRateData;
  }

}

export function getHeartRateLabel(bpm: number): string {
  if (bpm <= 0) {
    return 'Measuring…'
  }
  if (bpm < 60) {
    return 'Very calm'
  }
  if (bpm < 70) {
    return 'Resting'
  }
  if (bpm < 85) {
    return 'Calm & balanced'
  }
  if (bpm < 100) {
    return 'Energised'
  }
  return 'High energy'
}
