import 'package:pigeon/pigeon.dart';

//run in the root folder: flutter pub run pigeon --input pigeons/text_api.dart

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon/theoplayer_flutter_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/danieldallos/pigeon_multi_instance_demo/pigeon/TextApi.g.kt',
  kotlinOptions: KotlinOptions(
      package: 'com.danieldallos.pigeon_multi_instance_demo.pigeon',
  ),
  swiftOut: 'ios/Runner/pigeon/TextApi.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'pigeon_multi_instance_demo',
))


@HostApi()
abstract class NativeTextApi {
  void setText(String text);
}

@FlutterApi()
abstract class FlutterTextApiHandler {
  void textChanged(String text);
}