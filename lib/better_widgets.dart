import 'better_widgets_platform_interface.dart';

export 'package:better_widgets/widgets/fields/better_text_form_field.dart';

class BetterWidgets {
  Future<String?> getPlatformVersion() {
    return BetterWidgetsPlatform.instance.getPlatformVersion();
  }
}
