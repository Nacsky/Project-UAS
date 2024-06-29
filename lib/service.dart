import 'package:flutter/services.dart';

class NativeCommunication {
  static const MethodChannel _channel = MethodChannel('com.example.app/channel');

  Future<String> getPlatformVersion() async {
    try {
      final String result = await _channel.invokeMethod('getNativeData');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get native data: '${e.message}'.");
      return "Failed";
    }
  }
}