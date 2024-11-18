import 'dart:async';

import 'package:flutter/material.dart';

class BetterMaterialButton extends StatefulWidget {
  const BetterMaterialButton({
    super.key,
    this.minWidth,
    this.height,
    this.text,
    this.textWidget,
    required this.onPressed,
    this.isLoading = false,
    this.loadingWidget,
    this.isEnabled = true,
  });

  final double? minWidth;
  final double? height;

  final String? text;
  final Widget? textWidget;

  final FutureOr<void> Function() onPressed;
  final bool? isLoading;
  final Widget? loadingWidget;

  final bool isEnabled;

  @override
  State<BetterMaterialButton> createState() => _BetterMaterialButtonState();
}

class _BetterMaterialButtonState extends State<BetterMaterialButton> {
  bool autoIsLoading = false;
  void changeAutoIsLoading(bool value) {
    autoIsLoading = value;
    setState(() {});
  }

  bool get isLoading => widget.isLoading == true || autoIsLoading;

  @override
  Widget build(BuildContext context) {
    Widget child =
        widget.textWidget ?? widget.textWidget ?? Text(widget.text ?? "");

    if (widget.isLoading ?? false) {
      child = widget.loadingWidget ?? const CircularProgressIndicator();
    }

    return MaterialButton(
      minWidth: widget.minWidth,
      height: widget.height,
      onPressed: isLoading || widget.isEnabled == false
          ? null
          : () {
              changeAutoIsLoading(true);
              widget.onPressed();
              changeAutoIsLoading(false);
            },
      child: child,
    );
  }
}
