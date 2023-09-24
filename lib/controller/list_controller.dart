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
    List?finTodos = GetStorage().read<List>('fin');
    List? delTodos = GetStorage().read<List>('del');
    if (storedTodos != null) {
      list = storedTodos.map((e) => Item.fromJson(e)).toList().obs;
    }
    if (finTodos != null) {
      finishedList = finTodos.map((e) => Item.fromJson(e)).toList().obs;
    }
    if (delTodos != null) {
      deletedList = delTodos.map((e) => Item.fromJson(e)).toList().obs;
    }

    everAll([list,deletedList,finishedList], (_)
    {
      GetStorage().write('items', list.toList());
      GetStorage().write('fin', finishedList.toList());
      GetStorage().write('del', deletedList.toList());
    });
    super.onInit();
  }
  void editItem(int index, Rx<Item> updatedItem) {
    list[index] = updatedItem.value;
  }


}