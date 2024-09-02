import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'better_widgets_platform_interface.dart';

/// An implementation of [BetterWidgetsPlatform] that uses method channels.
class MethodChannelBetterWidgets extends BetterWidgetsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('better_widgets');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
