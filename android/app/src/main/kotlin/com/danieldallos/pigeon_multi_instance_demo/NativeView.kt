package com.danieldallos.pigeon_multi_instance_demo

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import com.danieldallos.pigeon_multi_instance_demo.pigeon.NativeTextApi
import com.danieldallos.pigeon_multi_instance_demo.pigeon.FlutterTextApiHandler
import com.danieldallos.pigeon_multi_instance_demo.pigeon.PigeonMultiInstanceBinaryMessengerWrapper

class NativeView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView, NativeTextApi {

    private val textView: TextView
    private val wrapper: LinearLayout

    private val flutterApi: FlutterTextApiHandler
    private val pigeonMessenger: PigeonMultiInstanceBinaryMessengerWrapper

    init {

        // wrapper view to maintain the correct sizing from native
        wrapper = LinearLayout(context)
        wrapper.id = viewId
        wrapper.setBackgroundColor(Color.GREEN)
        wrapper.layoutParams =  ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT)
        wrapper.gravity = Gravity.CENTER

        textView = TextView(context)
        textView.text = "NativeView_$viewId"

        wrapper.addView(textView)

        //setup pigeon
        pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(messenger, "id_$viewId");

        NativeTextApi.setUp(pigeonMessenger, this)
        flutterApi = FlutterTextApiHandler(pigeonMessenger)

    }


    override fun getView(): View? {
        return wrapper
    }

    override fun dispose() {
        //TODO("Not yet implemented")
    }

    //pigeon API
    override fun setText(text: String) {
        val finalText = "NativeView_$text"
        textView.text = finalText;
        flutterApi.textChanged(finalText, {})
    }


}