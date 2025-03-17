import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:techware/viewmodel/home_view_model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Techwarelab")),

      body: GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        didChangeDependencies: (state) {
          state.controller!.fetchHome();
        },
        initState: (_) {},
        builder: (viewmodel) {
          if (viewmodel.isloading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewmodel.errorMessage != null) {
            return Center(
              child: Text(
                viewmodel.errorMessage!.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return viewmodel.isloading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: viewmodel.homelist.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.all(10),
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
