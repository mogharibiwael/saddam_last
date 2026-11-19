import 'dart:developer';

import 'package:accounts_book/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/catch_receipt.dart';
import '../model/customer.dart';
import '../../../data/sqldb/sqldb.dart';

abstract class CustomersController extends GetxController {
  void changePage(int i, String page);
}


class CustomersControllerImp extends CustomersController {

  final customerId=0;
  final SqlDb _sqlDb = SqlDb();
  final customers = <Customer>[].obs;
  var filteredSummaries = <CatchReceipt>[].obs;

  final transactionSummaries = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    print('fjjfjjf');
    super.onInit();
    fetchCustomers();
    getTransactionSummaries();
    getData();
  }

  @override
  void changePage(int i, String page) {}

  Future<void> fetchCustomers() async {
    try {
      final List<Map<String, dynamic>> results = await _sqlDb.read("Customer");
      customers.value = results.map((map) => Customer.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching customers: $e');
    }
  }

  Future<void> getData()async{
    print('hi');

    // SELECT c.customer_id, c.customer_name, t.transaction_id, t.amount
    // FROM customers c
    // JOIN transactions t ON c.customer_id = t.customer_id
    // GROUP BY c.customer_id
try {
  var data = await _sqlDb.readData(
      "SELECT c.id, c.name,t.id, t.total FROM Customer c INNER JOIN CatchReceipt t ON c.id = t.customer_id "
  );
  print('data');
  print(data.length);
  log('$data');
  print('data');
}catch(e){
  print('e');
  print(e);
  print('e');
}
  }

  Future<void> addCustomer(Customer customer) async {
    try {
      final id = await _sqlDb.insert("Customer", {
        'userType': customer.userType,
        'name': customer.name,
        'phone': customer.phone,
        'phone2': customer.phone2,
        'address': customer.address,
        'create_at': DateTime.now().toIso8601String(),
        'update_at': DateTime.now().toIso8601String(),
      });
      await addReceipt(customerId: id,customerName: customer.name);
      await fetchCustomers();
      getTransactionSummaries();
    } catch (e) {
      print('Error adding customer: $e');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      await _sqlDb.update(
        "Customer",
        {
          'userType': customer.userType,
          'name': customer.name,
          'phone': customer.phone,
          'phone2': customer.phone2,
          'address': customer.address,
          'update_at': DateTime.now().toIso8601String(),
        },
        'id = ${customer.id}',
      );
      await fetchCustomers();
    } catch (e) {
      print('Error updating customer: $e');
    }
  }

  Future<void> deleteCustomer(int id) async {
    try {
      await _sqlDb.delete("Customer", "id = ?", id);
      await fetchCustomers();
    } catch (e) {
      print('Error deleting customer: $e');
    }
  }

  Future<void> getTransactionSummaries() async {
    try {
      final result = await getTransactionSummaryByCustomer();
      transactionSummaries.value = result;
    } catch (e) {
      print("Error fetching transaction summaries: $e");
    }
  }

  Future<bool> addReceipt({required int customerId, String name='',double price=0,double total=0,int forHim=3,required String customerName}) async {
    final result = await  insertCatchReceipt(
      name: name,
      customerId: customerId,
      price: price,
      total: total,
      forHim: forHim,
      customerName: customerName,
    );
    if (result > 0) {
      print('Receipt added successfully!');
      return true;
    } else {
      print('Failed to add receipt.');
      return false;

    }
  }

  Future<void> deleteCacheReceipt(int id) async {
    try {
      await _sqlDb.delete("CatchReceipt", "id = ?", id);
      getTransactionSummaries();
    } catch (e) {
      print('Error deleting cache receipt: $e');
    }
  }

  Future<void> deleteCustomers(int id) async {
    try {
      await _sqlDb.delete("Customer", "id = ?", id);
      fetchCustomers();
    } catch (e) {
      print('Error deleting cache receipt: $e');
    }
  }

  void openAddCustomerDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 20,
        backgroundColor: Colors.white,
        title: Text(
          'addUser'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.primaryColor),
        ),
        content: Form(
          key: formKey,
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildTextFormField('name', nameController, Icons.person),
                    const SizedBox(height: 15),
                    buildTextFormField('phone', phoneController, Icons.phone),
                    const SizedBox(height: 15),
                    buildTextFormField('address', addressController, Icons.home),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          buildDialogButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newCustomer = Customer(
                  id: 0,
                  userType: 1,
                  name: nameController.text,
                  phone: phoneController.text,
                  phone2: '',
                  address: addressController.text,
                  createAt: DateTime.now().toIso8601String(),
                  updateAt: DateTime.now().toIso8601String(),
                );
                Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
                Future.delayed(Duration(milliseconds: 400), () {
                  addCustomer(newCustomer);
                  Get.back(); // Close loading dialog
                  Get.back(); // Close form dialog
                });
              }
            },
            label: 'add',
            icon: Icons.add,
          ),
          buildDialogButton(
            onPressed: () => Get.back(),
            label: 'cancel',
            icon: Icons.cancel,
            color: AppColor.grey,
          ),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(icon),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'required'.tr : null,
    );
  }

  ElevatedButton buildDialogButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
    Color color = AppColor.primaryColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        children: [
          Text(label.tr),
          const SizedBox(width: 5),
          Icon(icon),
        ],
      ),
    );
  }

  // Method to search and filter summaries based on customer ID
  void searchTransactionSummariesByCustomerId(String customerId)async {

    var data = await _sqlDb.readCondition(
        "CatchReceipt",'customer_id = $customerId'
    );
    filteredSummaries.value = data.map((map) => CatchReceipt.fromMap(map)).toList();

    }

    // print('filteredSummaries' );
    // print(filteredSummaries );
    // print('filteredSummaries' );

  Future<List<Map<String, dynamic>>> getTransactionSummaryByCustomer() async {
    var mydb = await _sqlDb;
    return await mydb.readData('''
    SELECT
      id, 
      customer_id, 
      customer_name,
      name,
      create_at,
      price,
      total,
      COUNT(*) as transaction_count, 
      SUM(total) as total_sum, 
      MAX(create_at) as latest_transaction_date 
    FROM CatchReceipt
    GROUP BY customer_id
    ORDER BY latest_transaction_date DESC
  ''');
  }


  Future<int> insertCatchReceipt({
    required String name,
    required int customerId,
    required double price,
    required double total,
    required int forHim,
    required String customerName,
  }) async {
    var mydb = await _sqlDb;

    // Create the map of values for the columns
    Map<String, dynamic> data = {
      'name': name,
      'customer_id': customerId,
      'price': price,
      'total': total,
      'for_him': forHim,
      'customer_name': customerName,
      'create_at': DateTime.now().toIso8601String(),
      'update_at': DateTime.now().toIso8601String(),
    };

    // Insert into the CatchReceipt table and return the ID
    return await mydb.insert('CatchReceipt', data);
  }



}
