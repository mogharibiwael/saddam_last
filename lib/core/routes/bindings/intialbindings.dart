import 'package:accounts_book/feature/customers/controller/customers_controller.dart';
import 'package:get/get.dart';

import '../../../feature/customers/controller/add_transction.dart';
import '../../../feature/home/controller/homescreen_controller.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenControllerImp());
  }
}
class CustomersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomersControllerImp());
    Get.put(AddTransactionController());
  }
}
class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddTransactionController());
  }
}
