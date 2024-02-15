package com.example.edoktor_structure



import android.content.pm.PackageManager
import androidx.multidex.BuildConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "versionChannel"
    val versionCode = BuildConfig.VERSION_NAME


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "getVersion") {
                    try {
                        val pInfo =
                            packageManager.getPackageInfo(packageName, 0)
                        result.success(pInfo.versionName)
                    } catch (e: PackageManager.NameNotFoundException) {
                        result.error("VERSION_NOT_FOUND", "Version name not found", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }
}


