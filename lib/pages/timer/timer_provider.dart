import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'ticker.dart';
import 'timer_state.dart';

// class Timer extends AutoDisposeStreamNotifier<TimerState> {
//   final int _duration = 10;
//   final Ticker _ticker = const Ticker();
//
//   StreamSubscription<int>? _tickerSubscription;
//
//   @override
//   Stream<TimerState> build() {
//     return Stream.value(TimerInitial(_duration));
//   }
//
//   void startTimer() {
//     state = AsyncData(TimerRunning(_duration));
//     _tickerSubscription?.cancel();
//     _tickerSubscription = _ticker.tick(ticks: _duration).listen((duration) {
//       state = duration > 0
//           ? AsyncData(TimerRunning(duration))
//           : const AsyncData(TimerFinished());
//     });
//   }
//
//   void pauseTimer() {
//     // nullable
//     switch (state.value!) {
//       // pattern matching
//       case TimerRunning(:int duration):
//         _tickerSubscription?.pause();
//         state = AsyncData(TimerPaused(duration));
//       case _:
//     }
//   }
//
//   void resumeTimer() {
//     switch (state.value!) {
//       // pattern matching
//       case TimerPaused(:int duration):
//         _tickerSubscription?.resume();
//         state = AsyncData(TimerRunning(duration));
//       case _:
//     }
//   }
//
//   void resetTimer() {
//     _tickerSubscription?.cancel();
//     state = AsyncData(TimerInitial(_duration));
//   }
// }
//
// final timerProvider = StreamNotifierProvider.autoDispose<Timer, TimerState>(() {
//   return Timer();
// });

part 'timer_provider.g.dart';

@riverpod
class Timer extends _$Timer {
  final int _duration = 10;
  final Ticker _ticker = const Ticker();

  // 메모리 누수 방지
  StreamSubscription<int>? _tickerSubscription;

  @override
  Stream<TimerState> build() {
    ref.onDispose(() {
      print('[timerProvider] disposed');
      _tickerSubscription?.cancel();
    });
    return Stream.value(TimerInitial(_duration));
  }

  void startTimer() {
    state = AsyncData(TimerRunning(_duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: _duration).listen((duration) {
      state = duration > 0
          ? AsyncData(TimerRunning(duration))
          : const AsyncData(TimerFinished());
    });
  }

  void pauseTimer() {
    // nullable
    switch (state.value!) {
      // pattern matching
      case TimerRunning(:int duration):
        _tickerSubscription?.pause();
        state = AsyncData(TimerPaused(duration));
      case _:
    }
  }

  void resumeTimer() {
    switch (state.value!) {
      // pattern matching
      case TimerPaused(:int duration):
        _tickerSubscription?.resume();
        state = AsyncData(TimerRunning(duration));
      case _:
    }
  }

  void resetTimer() {
    _tickerSubscription?.cancel();
    state = AsyncData(TimerInitial(_duration));
  }
}