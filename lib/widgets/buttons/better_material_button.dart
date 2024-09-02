import 'package:flutter/material.dart';

class BetterMaterialButton extends StatefulWidget {
  const BetterMaterialButton({
    super.key,
    this.minWidth,
    this.height,
    this.text,
    this.textWidget,
    required this.onPressed,
    required this.isLoading,
    this.loadingWidget,
    required this.isEnabled,
  });

  final double? minWidth;
  final double? height;

  final String? text;
  final Widget? textWidget;

  final void Function() onPressed;
  final bool isLoading;
  final Widget? loadingWidget;

  final bool isEnabled;

  @override
  State<BetterMaterialButton> createState() => _BetterMaterialButtonState();
}

class _BetterMaterialButtonState extends State<BetterMaterialButton> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.textWidget ?? widget.textWidget ?? const Text("");

    if (widget.isLoading) {
      child = widget.loadingWidget ?? const CircularProgressIndicator();
    }

    return MaterialButton(
      minWidth: widget.minWidth,
      height: widget.height,
      onPressed: widget.isLoading || widget.isEnabled ? null : widget.onPressed,
      child: child,
    );
  }
}
