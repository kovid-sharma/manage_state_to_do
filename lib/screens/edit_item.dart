import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:manage_state_to_do/controller/list_controller.dart';

import '../models/list_item_model.dart';
class ItemEdit extends StatefulWidget {
  final int index;
  const ItemEdit({Key? key, required this.index}) : super(key: key);

  @override
  State<ItemEdit> createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  var todoController= Get.put(ListController());

  @override
  Widget build(BuildContext context) {

    TextEditingController textEditingController= TextEditingController(text: todoController.list[widget.index].title);

    TextEditingController descEditingController=TextEditingController(text: todoController.list[widget.index].description);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                // textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Add New Task",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 25.0,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                autofocus: true,
                controller: textEditingController,
              ),
            ),
            Expanded(
              child: TextField(
                // textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Describe your task",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                autofocus: true,
                controller: descEditingController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ignore: deprecated_member_use
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                ElevatedButton(
                  child: const Text('Edit'),

                  onPressed: () {
                    todoController.editItem(widget.index, Item(title:textEditingController.text ,description: descEditingController.text).obs);
                    Get.back();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
