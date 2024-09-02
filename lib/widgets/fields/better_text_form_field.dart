import 'package:flutter/material.dart';

class BetterTextFormFieldStyle {}

class BetterTextFormField extends StatefulWidget {
  const BetterTextFormField({
    super.key,
    this.controller,
    this.builder,
    this.enabled = true,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.hintText,
    this.suffixIcon,
  });

  final String? hintText;

  /// Caso queira customizar
  final Widget Function(
    BuildContext context,
    TextFormField child,
    TextEditingController controller,
  )? builder;

  /// Um controller já é instanciado automaticamente
  /// Mas caso queira especificar um fique à vontade.
  final TextEditingController? controller;

  final bool enabled;
  final bool obscureText;

  final void Function(String)? onFieldSubmitted;

  final Widget? suffixIcon;

  @override
  State<BetterTextFormField> createState() => _BetterTextFormFieldState();
}

class _BetterTextFormFieldState extends State<BetterTextFormField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = TextFormField(
      enabled: widget.enabled,
      controller: controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
      ),
    );

    if (widget.builder != null) {
      return widget.builder!(context, child, controller);
    }

    return child;
  }
}

class BetterPasswordTextFormField extends StatefulWidget {
  const BetterPasswordTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.enabled = true,
    this.onFieldSubmitted,
    this.builder,
  });

  final String? hintText;

  /// Caso queira customizar
  final Widget Function(
    BuildContext context,
    BetterTextFormField child,
    TextEditingController controller,
    bool isObscure,
  )? builder;

  /// Um controller já é instanciado automaticamente
  /// Mas caso queira especificar um fique à vontade.
  final TextEditingController? controller;

  final bool enabled;

  final void Function(String)? onFieldSubmitted;

  @override
  State<BetterPasswordTextFormField> createState() =>
      _BetterPasswordTextFormFieldState();
}

class _BetterPasswordTextFormFieldState
    extends State<BetterPasswordTextFormField> {
  late final TextEditingController controller;

  bool obscureText = true;
  void toggleIsObscure() {
    obscureText = !obscureText;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = BetterTextFormField(
      controller: controller,
      enabled: widget.enabled,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: toggleIsObscure,
        icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
      ),
    );

    if (widget.builder != null) {
      return widget.builder!(
        context,
        child,
        controller,
        obscureText,
      );
    }

    return child;
  }
}
