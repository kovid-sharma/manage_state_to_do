

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/list_item_model.dart';
class ListController extends GetxController{
  var list= List<Item>.empty().obs;
  var finishedList= List<Item>.empty().obs;
  var deletedList= List<Item>.empty().obs;
  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('items');
    if (storedTodos != null) {
      list = storedTodos.map((e) => Item.fromJson(e)).toList().obs;
    }
    ever(list, (_) {
      GetStorage().write('items', list.toList());
    });
    super.onInit();
  }
  void editItem(int index, Rx<Item> updatedItem) {
    list[index] = updatedItem.value;
  }


}