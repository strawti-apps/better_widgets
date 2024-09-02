import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'better_widgets_method_channel.dart';

abstract class BetterWidgetsPlatform extends PlatformInterface {
  /// Constructs a BetterWidgetsPlatform.
  BetterWidgetsPlatform() : super(token: _token);

  static final Object _token = Object();

  static BetterWidgetsPlatform _instance = MethodChannelBetterWidgets();

  /// The default instance of [BetterWidgetsPlatform] to use.
  ///
  /// Defaults to [MethodChannelBetterWidgets].
  static BetterWidgetsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BetterWidgetsPlatform] when
  /// they register themselves.
  static set instance(BetterWidgetsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
