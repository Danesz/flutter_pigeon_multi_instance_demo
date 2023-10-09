import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pigeon_multi_instance_demo/pigeon/pigeon_multi_instance_wrapper.dart';
import 'package:pigeon_multi_instance_demo/pigeon/theoplayer_flutter_api.g.dart';

typedef PlatformViewCreatedCallback = void Function(NativeViewController controller);

class NativeView extends StatelessWidget {
  PlatformViewCreatedCallback platformViewCreatedCallback;

  NativeView({super.key, required this.platformViewCreatedCallback});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'nativeview';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initExpensiveAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener((id) {
                params.onPlatformViewCreated(id);
                platformViewCreatedCallback(NativeViewController(id));
              })
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: (id) {
              platformViewCreatedCallback(NativeViewController(id));
            });
      default:
        return Text("Unsupported platform $defaultTargetPlatform");
    }
  }
}

class NativeViewController implements FlutterTextApiHandler {
  late final NativeTextApi _nativeAPI;
  late final PigeonMultiInstanceBinaryMessengerWrapper _pigeonMessenger;

  NativeViewController(int id) {
    _pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(suffix: 'id_$id');

    _nativeAPI = NativeTextApi(binaryMessenger: _pigeonMessenger);
    FlutterTextApiHandler.setup(this, binaryMessenger: _pigeonMessenger);
  }

  @override
  void textChanged(String text) {
    print("textChanged: $text");
  }

  void changeText(String newText) {
    _nativeAPI.setText(newText);
  }
}