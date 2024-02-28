class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) {
      print('===== ticks:: $ticks ====');
      print('===== x:: $x ====');
      return ticks - x - 1;
    })
        .take(ticks);
  }
}