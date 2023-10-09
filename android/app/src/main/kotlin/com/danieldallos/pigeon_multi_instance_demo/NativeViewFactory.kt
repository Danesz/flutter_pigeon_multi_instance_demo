package com.danieldallos.pigeon_multi_instance_demo

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewFactory(createArgsCodec: MessageCodec<Any>?) : PlatformViewFactory(createArgsCodec) {

    lateinit var messenger: BinaryMessenger

    constructor(messenger: BinaryMessenger) : this(StandardMessageCodec.INSTANCE) {
        this.messenger = messenger
    }

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return NativeView(context!!, viewId, args, messenger);
    }
}