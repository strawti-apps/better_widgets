import 'package:flutter_test/flutter_test.dart';
import 'package:better_widgets/better_widgets.dart';
import 'package:better_widgets/better_widgets_platform_interface.dart';
import 'package:better_widgets/better_widgets_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBetterWidgetsPlatform
    with MockPlatformInterfaceMixin
    implements BetterWidgetsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BetterWidgetsPlatform initialPlatform = BetterWidgetsPlatform.instance;

  test('$MethodChannelBetterWidgets is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBetterWidgets>());
  });

  test('getPlatformVersion', () async {
    BetterWidgets betterWidgetsPlugin = BetterWidgets();
    MockBetterWidgetsPlatform fakePlatform = MockBetterWidgetsPlatform();
    BetterWidgetsPlatform.instance = fakePlatform;

    expect(await betterWidgetsPlugin.getPlatformVersion(), '42');
  });
}
