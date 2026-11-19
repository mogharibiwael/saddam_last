import 'package:accounts_book/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/homescreen_controller.dart';

class MyCustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColor.primaryColor),
            child: Center(
              child: Text(
                'appName'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          _buildListTile(Icons.add, 'addAmount'.tr, Colors.green, () {}),
          _buildListTile(Icons.calendar_today, 'totalReport'.tr, null, () {}),
          _buildListTile(Icons.calendar_today, 'detailsReport'.tr, null, () {}),
          _buildListTile(Icons.calendar_today, 'monthlyReport'.tr, null, () {}),
          _buildListTile(Icons.category, 'categoryReport'.tr, null, () {}),
          _buildListTile(Icons.swap_horiz, 'accountMovement'.tr, null, () {}),
          _buildListTile(Icons.repeat, 'autoRepeat'.tr, null, () {}),
          _buildListTile(Icons.backup, 'backup'.tr, null, () {}),
          _buildListTile(Icons.restore, 'restoreDatabase'.tr, null, () {}),
          _buildListTile(Icons.cloud_upload, 'googleDrive'.tr, null, () {}),
          _buildListTile(Icons.settings, 'settings'.tr, null, () {}),
          _buildListTile(Icons.support, 'support'.tr, null, () {}),
          _buildListTile(Icons.info, 'about'.tr, null, () {}),
          _buildListTile(Icons.share, 'share'.tr, null, () {}),
          _buildListTile(Icons.exit_to_app, 'exit'.tr, null, () {}),
        ],
      ),
    );
  }

  ListTile _buildListTile(IconData icon, String title, Color? iconColor, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.black),
      title: Text(title),
      onTap: onTap,
    );
  }
}


Widget buildGridView(HomeScreenControllerImp controller) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
    ),
    itemCount: controller.imagesList.length,
    itemBuilder: (context, index) {
      final image = controller.imagesList[index]['image']!;
      final name = controller.imagesList[index]['name']!.tr;
      return InkWell(
        onTap: (){
          controller.gotTo(controller.imagesList[index]['name']!);
        },
        child: Card(
          color: AppColor.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image, width: 70, height: 70),
              const SizedBox(height: 5),
              Text(name,style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
        ),
      );
    },
  );
}

