import 'package:better_widgets/better_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            BetterTextFormField(
              builder: (context, child, controller) {
                // O controller é implementado dentro do widget.
                // Se quiser colocar algo aqui dentro ou usar o controller

                return child;
              },
            ),
            BetterPasswordTextFormField(
              hintText: "Senha",
              onFieldSubmitted: (password) {},
            ),
          ],
        ),
      ),
    );
  }
}
