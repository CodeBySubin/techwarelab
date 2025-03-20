import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techware/viewmodel/home_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeViewModel());

  @override
  void initState() {
    super.initState();
    homeController.fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Techwarelab")),
      body: GetBuilder<HomeViewModel>(
        builder: (viewmodel) {
          if (viewmodel.isloading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewmodel.errorMessage != null) {
            return Center(
              child: Text(
                viewmodel.errorMessage?.message ?? "Something went wrong",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: viewmodel.homelist.length,
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(viewmodel.homelist[i].title),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
