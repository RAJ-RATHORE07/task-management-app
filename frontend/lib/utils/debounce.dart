import 'dart:async';

class Debouncer {
  late final int milliseconds;
  Timer? _timer;

  Debouncer(this.milliseconds);

  run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}