package com.example.deobfuscate

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.example.deobfuscate/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getNativeMessage" -> {
                    throw RuntimeException("RuntimeException from getNativeMessage!")
                    val message = "Evan, Hello from Android!"
                    result.success(message)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
