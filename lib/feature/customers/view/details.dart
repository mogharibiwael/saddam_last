import 'package:accounts_book/feature/customers/controller/customers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';
import '../../../core/routes/routes_names.dart';
import '../controller/add_transction.dart';

class CustomerDetailsPage extends GetView<CustomersControllerImp> {

  @override
  Widget build(BuildContext context) {
    var id=0;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Customer Details'), // Updated title
            backgroundColor: Colors.blue, // Use your primary color
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Search action
                },
              ),
              IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  // Export PDF action
                },
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height * 0.77,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _buildTransactionHeader(),
                Divider(),
                Obx(
                        () {

                          print('controller.filteredSummaries.length');
                          print(controller.filteredSummaries.length);
                          print('controller.filteredSummaries.length');
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.filteredSummaries.length,
                        itemBuilder: (context, index) {
                          List listData = controller.filteredSummaries;
                          var  indexOfT = listData[index].createdAt.indexOf('T');

                          id= listData[index].customerId;
                          print('id');
                          print(id);
                          print('id');

                          // Extract the date part
                          String datePart = listData[index].createdAt.substring(0, indexOfT);
                          return _buildTransactionRow(
                            datePart ?? "12-12-2022",
                            listData[index].name??"waelelelele",
                            listData[index].price?? 22,
                            listData[index].forHim ==1?true :false
                          );
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
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
                Get.toNamed(AppRoute.addReceipt,arguments: id);

                Get.find<AddTransactionController>().alertDialogMethod(context, id);
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'addReceipt'.tr, // Updated text
                style: const TextStyle(color: AppColor.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderItem("التاريخ", flex: 2),
          _buildHeaderItem("المبلغ", flex: 2),
          _buildHeaderItem("التفاصيل", flex: 3),
          _buildHeaderItem(""),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(String date, String details, int amount, bool isPositive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDataItem(date, flex: 2),
          _buildDataItem(amount.toString(), flex: 2),
          _buildDataItem(details, flex: 3),
          _buildStatusIcon(isPositive),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataItem(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildStatusIcon(bool isPositive) {
    return Icon(
      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
      color: isPositive ? Colors.green : Colors.red,
    );
  }
}
