import 'package:flutter/material.dart';

extension BetterBuildContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get themeData => Theme.of(this);
}
