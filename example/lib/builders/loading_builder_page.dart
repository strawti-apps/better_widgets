import 'package:better_widgets/better_widgets.dart';
import 'package:flutter/material.dart';

class LoadingBuilderPage extends StatefulWidget {
  const LoadingBuilderPage({super.key});

  @override
  State<LoadingBuilderPage> createState() => _LoadingBuilderPageState();
}

class _LoadingBuilderPageState extends State<LoadingBuilderPage> {
  List<String> users = [];
  Future<void> getUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    users = ["A", "B", "C"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Better Loading Builder'),
      ),
      body: Column(
        children: [
          BetterLoadingBuilder(
            builder: (context, loading, changeLoading) {
              if (loading) {
                return const CircularProgressIndicator();
              }

              return Column(
                children: [
                  BetterMaterialButton(
                    text: "Buscar usuários",
                    onPressed: () async {
                      changeLoading(true);
                      await getUsers();
                      changeLoading(false);
                    },
                    isLoading: loading,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
