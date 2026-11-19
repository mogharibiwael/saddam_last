import 'package:accounts_book/core/constant/color.dart';
import 'package:accounts_book/core/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_transction.dart';
import '../controller/customers_controller.dart';
import 'details.dart';

class CustomerPage extends GetView<CustomersControllerImp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'customer'.tr,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            iconTheme: IconThemeData(
              color: AppColor.white,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: AppColor.white),
                onPressed: () {
                  // Search action
                },
              ),
            ],
            backgroundColor: AppColor.primaryColor,
          ),
          body: Obx(() {
            if (controller.customers.isEmpty) {
              return Center(child: Text('No transactions found'));
            }

            return ListView.builder(
              itemCount: controller.customers.length,
              itemBuilder: (context, index) {
                var transactionSummary = controller.customers[index];
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: userTile(
                    transactionSummary.id,
                    transactionSummary.id,
                    '${transactionSummary.name}',
                    10,
                    10,
                    Colors.green,
                    true,
                    context

                    // Pass the entire summary for editing/deleting
                  ),
                );
              },
            );
          }),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.zero,
            height: 60,
            color: AppColor.primaryColor,
            child: TextButton.icon(
              onPressed: () {
                Get.find<CustomersControllerImp>().openAddCustomerDialog();
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'addUser'.tr,
                style: const TextStyle(color: AppColor.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget userTile(
      int id,int customerId, String name, int score, int messages, Color indicatorColor, bool isUp,context) {
    return GestureDetector(
      onLongPress: (){
        _showEditDeleteDialog(id);
      },
      onTap: () {
        // Navigate to customer details page and pass the customer data
        controller.searchTransactionSummariesByCustomerId('$customerId');
        Get.toNamed(AppRoute.customerDetails);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              isUp ? Icons.arrow_upward : Icons.arrow_downward,
              color: indicatorColor,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10),
                Text('$score', style: TextStyle(fontSize: 16)),
                SizedBox(width: 50),
                CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  child: Text(
                    messages.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10), // Spacing between avatar and name
                Container(
                  width: 140,
                  alignment: Alignment.centerRight,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(width: 10), // Spacing between name and icon
                Container(
                  width: 50,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () {

                      print('customerId');
                      print(customerId);
                      print('customerId');


                      Get.toNamed(AppRoute.addReceipt, arguments: customerId);
                      Get.find<AddTransactionController>().alertDialogMethod(context, id);

                      // Add action (optional)
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDeleteDialog(id) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  // Handle edit action
                  Navigator.of(context).pop();
                  // Get.find<CustomersControllerImp>().openEditCustomerDialog(transactionSummary);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  // Handle delete action
                  controller.deleteCustomers(id);
                  Navigator.of(context).pop();
                  // Get.find<CustomersControllerImp>().deleteCustomer(transactionSummary);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}