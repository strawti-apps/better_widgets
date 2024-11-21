import 'package:flutter/material.dart';

class BetterIconFilledButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  const BetterIconFilledButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minWidth: 60,
      height: 60,
      child: icon,
    );
  }
}
