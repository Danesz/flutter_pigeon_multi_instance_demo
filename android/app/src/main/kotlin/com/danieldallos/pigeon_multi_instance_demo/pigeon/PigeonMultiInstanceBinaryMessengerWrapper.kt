package com.danieldallos.pigeon_multi_instance_demo.pigeon

import io.flutter.plugin.common.BinaryMessenger
import java.nio.ByteBuffer

class PigeonMultiInstanceBinaryMessengerWrapper(
    private val messenger: BinaryMessenger,
    private val channelSuffix: String,
) : BinaryMessenger {

    override fun send(channel: String, message: ByteBuffer?) {
        messenger.send("$channel/$channelSuffix", message)
    }

    override fun send(channel: String, message: ByteBuffer?, callback: BinaryMessenger.BinaryReply?) {
        messenger.send("$channel/$channelSuffix", message, callback)
    }

    override fun setMessageHandler(channel: String, handler: BinaryMessenger.BinaryMessageHandler?) {
        messenger.setMessageHandler("$channel/$channelSuffix", handler)
    }
}