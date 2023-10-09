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


class NativeView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView {

    private val textView: TextView
    private val wrapper: LinearLayout

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
        textView.text = "NativeView_$viewId";

        wrapper.addView(textView)
    }


    override fun getView(): View? {
        return wrapper
    }

    override fun dispose() {
        //TODO("Not yet implemented")
    }


}