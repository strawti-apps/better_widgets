import 'package:flutter/widgets.dart';

class BetterForm extends StatefulWidget {
  const BetterForm({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    FormState? formState,
  ) builder;

  @override
  State<BetterForm> createState() => _BetterFormState();
}

class _BetterFormState extends State<BetterForm> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _formKey.currentState);
  }
}
