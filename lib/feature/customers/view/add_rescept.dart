import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_transction.dart';

class AddTransactionPage extends  GetView<AddTransactionController> {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Transaction'),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _buildTextField(controller.priceController, 'Price', isNumeric: true),
            const SizedBox(height: 16),
            TextField(
              controller: controller.dateController,
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
            _buildTextField(controller.nameController, 'Details'),
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
                        groupValue: controller.selectedValue.value,
                        onChanged: (value) {
                          controller.selectedValue.value = value!;
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<int>(
                        title: Text("On It"),
                        value: 0,
                        groupValue: controller.selectedValue.value,
                        onChanged: (value) {
                          controller.selectedValue.value = value!;
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            controller.submitData();
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
      controller.dateController.text = formattedDate;
    }
  }
}