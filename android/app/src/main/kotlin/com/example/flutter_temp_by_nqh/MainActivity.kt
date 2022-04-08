package com.example.flutter_temp_by_nqh

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        MethodChannel(flutterEngine?.dartExecutor, "flavor").setMethodCallHandler { _, result -> result.success(FLAVOR) }
    }
}
