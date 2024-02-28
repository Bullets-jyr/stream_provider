import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'timer_provider.dart';

class TimerValue extends ConsumerWidget {
  const TimerValue({super.key});

  String zeroPaddedTwoDigits(double ticks) {
    return ticks.floor().toString().padLeft(2, '0');
  }

  String formatTimer(int ticks) {
    final minutes = zeroPaddedTwoDigits((ticks / 60) % 60);
    final seconds = zeroPaddedTwoDigits(ticks % 60);

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    print(timerState);

    // AsyncData || orElse
    return timerState.maybeWhen(
      data: (value) => Text(
        formatTimer(value.duration),
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      // 필수
      orElse: () => const SizedBox.shrink(),
    );
  }
}