// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticker_provider.g.dart';

// final tickerProvider = StreamProvider<int>((ref) {
//   ref.onDispose(() {
//     print('[tickerProvider] disposed');
//   });
//   0부터 시작합니다.
//   return Stream.periodic(const Duration(seconds: 1), (t) => t + 1).take(60);
// });

@riverpod
Stream<int> ticker(TickerRef ref) {
  ref.onDispose(() {
    print('[tickerProvider] disposed');
  });
  return Stream.periodic(const Duration(seconds: 1), (t) => t + 1).take(60);
}