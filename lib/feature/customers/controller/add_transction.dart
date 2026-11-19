import 'package:accounts_book/feature/customers/controller/customers_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController{

  int ? customerId;

  CustomersControllerImp controllerImp=Get.find();
  DateTime date = DateTime.now();
  String today = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  late TextEditingController dateController ;
  final RxBool forHim = false.obs;
  RxInt selectedValue = 0.obs;
  late bool result=false;// Default selected value





  void submitData() async{


    await saveTransaction();
    print(result);
    if (result == false) {
      Get.snackbar('Error', 'Please fill in all fields correctly');
      return;
    }



    Get.snackbar('Success', 'Transaction added successfully');
    // Clear the fields after submission
    nameController.clear();
    customerIdController.clear();
    priceController.clear();
    totalController.clear();
    forHim.value = false;
    // Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    dateController=TextEditingController(text: '${date.day}-${date.month}-${date.year}');

  }


  saveTransaction()async{


    result=await controllerImp.addReceipt(customerId: customerId!, customerName: nameController.text,name: nameController.text,price: double.parse(priceController.text),forHim: selectedValue.value);
    print('result.value');
    print(result);
    print(result.runtimeType);
    print('result.value');
  }


  AlertDialog alertDialogMethod(context, id) {
    customerId = id;

    return AlertDialog(
      backgroundColor: Colors.transparent, // Set background color to transparent
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildTextField(priceController, 'Price', isNumeric: true),
              const SizedBox(height: 16),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Selected Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () {
                  selectDate(context);
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(nameController, 'Details'),
              Obx(() {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RadioListTile<int>(
                          title: Text("For Him"),
                          value: 1,
                          groupValue: selectedValue.value,
                          onChanged: (value) {
                            selectedValue.value = value!;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<int>(
                          title: Text("On It"),
                          value: 0,
                          groupValue: selectedValue.value,
                          onChanged: (value) {
                            selectedValue.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
              ElevatedButton(
                onPressed: () {
                  submitData();
                  Get.back();
                },
                child: Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      String formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      dateController.text = formattedDate;
    }
  }
  // Function to show the DatePicker and handle the selected date

}