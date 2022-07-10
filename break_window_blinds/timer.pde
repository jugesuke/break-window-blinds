class Timer {
  // Start
  // 08:00 JST     0F
  // 21:00 JST 23400F
  // 1h 1800F
  // 1min 30F
  // End
  PFont font;
  Timer(PFont font) {
    this.font = font;
  }
  void draw(int x, int y, int frame) {
    int[] time = convertFrame2Time(frame);
    String hour;
    String sec;
    if (0 <= time[0] && time[0] < 10) {
      hour = "0" + time[0];
    } else {
      hour = str(time[0]);
    }
    if (0 <= time[1] && time[1] < 10) {
      sec = "0" + time[1];
    } else {
      sec = str(time[1]);
    }
    fill(231);
    textFont(font);
    text(hour + ":" + sec, x, y);
  }
  int convertTime2Frame(int[] time) {
    return time[0] * 1800 + time[1] *30;
  }
  int[] convertFrame2Time(int frame) {
    int hour = convertFrame2Hour(frame) + 8;
    int sec = convertFrame2Sec(frame % 1800);
    int[] time = {hour, sec};
    return time;
  }
  int convertFrame2Sec(int frame) {
    return frame /30;
  }
  int convertFrame2Hour(int frame) {
    return frame / (30 * 60);
  }
}
