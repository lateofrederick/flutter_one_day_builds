import 'package:localstorage/localstorage.dart';

class Cache {
  final LocalStorage storage = new LocalStorage("countdown");

  // save the time to localStorage
  void saveTime(String currentTime) async {
    await storage.ready;
    storage.setItem("countDownTime", currentTime);
  }

  // get the time form localStorage
  Future<Duration> getTimeFromCache() async {
    await storage.ready;
    String data = storage.getItem("countDownTime");
    if (data == null) {
      return null;
    }
    return parseDuration(data);
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  void clearLocalStorage() {
    storage.clear();
  }
}
