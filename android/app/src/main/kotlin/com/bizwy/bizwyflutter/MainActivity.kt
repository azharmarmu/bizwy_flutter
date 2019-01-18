package com.bizwy.bizwyflutter

import android.os.Bundle
import android.util.Base64

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import java.util.logging.Logger
import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec

class MainActivity : FlutterActivity() {

    companion object {
        const val CHANNEL = "flutter.bizwy.com.channel"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            val log = Logger.getLogger(MainActivity::class.java.name)
            log.warning(call.method)
            if (call.method == "getEncryptedValue") {
                val input = call.argument<Any>("input") as String
                val encryption = getEncryptedValue(input)
                result.success(encryption)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getEncryptedValue(input: String): String {
        var crypted: ByteArray? = null
        try {
            val key = SecretKeySpec(getSecretEncryptionKey().toByteArray(), "AES")
            val cipher = Cipher.getInstance("AES/ECB/PKCS5Padding")
            cipher.init(Cipher.ENCRYPT_MODE, key)
            crypted = cipher.doFinal(input.toByteArray(charset("UTF-8")))
        } catch (e: Exception) {
            println(e.toString())
        }
        return Base64.encodeToString(crypted, Base64.DEFAULT)
    }

    @Throws(Exception::class)
    fun getSecretEncryptionKey(): String {
        return "dmlkgPMSmh690377"
    }
}
