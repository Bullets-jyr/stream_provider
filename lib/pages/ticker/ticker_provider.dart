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

// StreamProvider는 Stream을 expose하고 listen할 수 있게 해주는 Provider입니다.
// Stream은 어떤 측면에서 연속되는 Future value의 집합이라고도 볼 수 있기 때문에 StreamProvider가
// expose하는 value를 처리하는 방식은 futureProvider에서 expose하는 value를 처리하는 방식과 비슷한 측면이 있습니다.
// 그렇기 때문에 futureProvider와 마찬가지로 asyncvalue를 state로 사용합니다.
// streamProvider는 주로 일정시간동안 값이 변하는 data source로 부터 계속 데이터를 읽거나
// source에 데이터를 쓰는 경우에 활용이 됩니다.
// 대표적인 예로는 Firebase를 활용한 authentication 앱이나 채팅앱, Battery level을 일정시간 간격으로 표시하는 앱
// 주식정보가 변할 때마다 알려주는 앱등이 있습니다. 이런 앱은 데이터가 자주 변하기 때문에 매번 새로운 데이터가 생길 때 마다
// 커넥션을 셋업하고 데이터를 송-수신하는 것 보다는 커넥션 셋업후 커넥션을 계속 열어둔 상태에서 data를 주고 받는 것이 더 효율적입니다.

// ticker_provider.dart 파일을 오픈한 후 flutter_riverpod package를 import하겠습니다.
// 다음으로 streamProvider code snipet generator를 이용해 streamProvider template를 만든 후
// 이름을 tickerProvider로 수정하 타입으로 integer를 줍니다. async*는 삭제하고 function body에서
// stream.periodic factory constructor를 이용해 1초마다 반복적으로 이벤트를 emit하는 stream을 create합니다.
// event의 value들은 callback 함수를 매 1초마다 호출해서 계산을 합니다.
// 이 콜백은 0부터 시작해서 1초마다 1씩증하는 integer를 argument로 받아 argument에 1을 더한 값을 리턴합니다.
// 그리고 take 60을 호출해 emit되는 value를 최대 60개까지로 제한하겠습니다.
// 그리고 ref의 onDispose함수에서 ticker provider disposed를 출력하겠습니다.

// 이번에는 riverpod_generator를 이용해서 streamProvider를 generate하겠습니다.
// riverpod_annotation package를 import하고 riverpod part를 이용해 part directive를 만들겠습니다.
// riverpod stream을 입력해 streamProvider template를 만든 후 stream의 타입으로는 integer를 function name으로는
// ticker를 주고 ref는 TickerRef로 수정하겠습니다.
// 그리고 function body에서 아까 만든 stream.periodic factory constructor를 붙여넣기 하겠습니다.
// lower case r riverpod annotation을 사용할 경우 Provider가 listen되지 않을 경우 autoDispose되지만
// manual하게 Provider를 generate시켰을 경우에는 반대로 keepAlive가 default인점 기억하시기 바랍니다.
// 만약 riverpod_generator를 사용해서 만든 Provider를 autoDispose가 아닌 keepAlive Provider로 만들기 위해서는
// 대문자 R Riverpod로 어노테이션한 후 keepAlive argument의 값으로 true를 줘야한다는 점도 기억하시기 바랍니다.
// 그리고 최근에 StreamNotifier가 추가되었습니다. StreamNotifier에는 뒤에서 살펴볼 StateNotifier, Notifier, AsyncNotifier와
// 유사하게 Stream과 관련된 복잡한 비즈니스 로직을 사용할 수 있습니다. StreamNotifier에 대해서는 AsyncNotifier를 알아보는 설명을 드리겠습니다.
// 그때도 지금의 stream_provider 앱을 사용할 예정입니다.