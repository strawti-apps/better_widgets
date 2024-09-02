#include "include/better_widgets/better_widgets_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "better_widgets_plugin.h"

void BetterWidgetsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  better_widgets::BetterWidgetsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
