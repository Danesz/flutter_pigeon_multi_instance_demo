package com.danieldallos.pigeon_multi_instance_demo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry.registerViewFactory("nativeview", NativeViewFactory(flutterEngine.dartExecutor.binaryMessenger))
    }
}
