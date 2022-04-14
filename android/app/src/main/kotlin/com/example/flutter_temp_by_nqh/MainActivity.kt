package com.example.flutter_temp_by_nqh

import android.os.Bundle
import com.example.flutter_temp_by_nqh.BuildConfig.FLAVOR
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        MethodChannel(flutterEngine?.dartExecutor, "flavor").setMethodCallHandler { _, result -> result.success(FLAVOR) }
    }
}
