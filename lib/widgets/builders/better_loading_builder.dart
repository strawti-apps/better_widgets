import 'package:flutter/material.dart';

///
class BetterLoadingBuilder extends StatefulWidget {
  const BetterLoadingBuilder({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    bool loading,
    void Function(bool value) changeLoading,
  ) builder;

  @override
  State<BetterLoadingBuilder> createState() => _LoadingBuilderState();
}

class _LoadingBuilderState extends State<BetterLoadingBuilder> {
  bool loading = false;
  void changeLoading(bool value) {
    loading = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, loading, changeLoading);
  }
}
