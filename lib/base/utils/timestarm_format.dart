import 'package:date_format/date_format.dart';

extension TimestampFormat on int {
  String convertToAgo() {
    Duration diff = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(this));

    if (diff.inDays >= 7) {
      return formatDate(DateTime.fromMillisecondsSinceEpoch(this), [mm, '-', dd]);
    } else if (diff.inDays >= 1) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds}s ago';
    } else {
      return 'just now';
    }
  }

  String dateFormat() {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(this), [mm, '-', dd, ' ', HH, ':', nn]);
  }
}
