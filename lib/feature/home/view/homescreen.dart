import 'package:accounts_book/core/constant/speacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homescreen_controller.dart';
import '../../../../core/constant/color.dart';
import '../widgets.dart';

class HomeScreen extends GetView<HomeScreenControllerImp> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: MyCustomDrawer(),
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text("appName".tr, style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.white),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.pagePadding),
        child: GetBuilder<HomeScreenControllerImp>(
          builder: (controller) => buildGridView(controller),
        ),
      ),
    );
  }

}

