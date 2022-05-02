
class DurationUtils {
  static String format(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String formatDesc(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (minutes <= 0) {
      return "${seconds}s";
    }
    if (duration.inHours <= 0) {
      return "${minutes}m${seconds}s";
    }
    return "${duration.inHours}h${minutes}m${seconds}s";
  }
}