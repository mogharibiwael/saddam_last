import 'package:get/get.dart';

import '../../../../core/constant/imgaeasset.dart';
import '../../../core/routes/routes_names.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int i,String page);
  gotTo(String i);
}

class HomeScreenControllerImp extends HomeScreenController {

  var imagesList=[
    {"name":"public","image": AppImageAsset.select},
    {"name":"customer","image": AppImageAsset.customer},
    {"name":"expenses","image": AppImageAsset.accounting},
    {"name":"income","image": AppImageAsset.cash},


  ];

  @override
  changePage(int i,String page) {

  }

  @override
  // goToCustomers() {
  //   Get.toNamed(
  //     AppRoute.customer
  //   );
  // }

  @override
  gotTo(String route){
    Get.toNamed(route);
  }
}
