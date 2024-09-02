
import 'better_widgets_platform_interface.dart';

class BetterWidgets {
  Future<String?> getPlatformVersion() {
    return BetterWidgetsPlatform.instance.getPlatformVersion();
  }
}
