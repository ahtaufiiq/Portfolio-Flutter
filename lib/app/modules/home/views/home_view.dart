import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: GetX<HomeController>(
          // UI yg reactive perlu ditambahin ini
          builder: (_) {
            return ListView.builder(
                itemCount: _.posts.length,
                itemBuilder: (context, index) {
                  return Text(_.posts[index]);
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => controller.increment(controller.posts.length)));
  }
}
