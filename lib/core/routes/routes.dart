import 'package:get/get.dart';

import '../../feature/customers/view/add_rescept.dart';
import '../../feature/customers/view/customers.dart';
import '../../feature/customers/view/details.dart';
import '../../feature/home/view/homescreen.dart';
import 'bindings/intialbindings.dart';
import 'routes_names.dart';



List<GetPage<dynamic>>? routes = [

  GetPage(name: "/", page: () => const HomeScreen()),
  GetPage(name: AppRoute.customer, page: () =>  CustomerPage(),bindings: [CustomersBindings()]),
  GetPage(name: AppRoute.customerDetails, page: () =>  CustomerDetailsPage(),bindings: [CustomersBindings()]),
  GetPage(name: AppRoute.addReceipt, page: () =>  AddTransactionPage(),bindings: [AddTransactionBinding()]),

];
