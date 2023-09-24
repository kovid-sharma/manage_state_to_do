import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_state_to_do/screens/edit_item.dart';

import '../controller/list_controller.dart';
import 'add_item.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  var todoController= Get.put(ListController());
  String selectedValue='All';
  int workWith=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        title: const Text('TODO LIST'),
        centerTitle: true,
        leading:  Container(
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
              value: selectedValue.isNotEmpty ? null : selectedValue,
              icon: const Icon(Icons.keyboard_arrow_down,size: 20,),
              items: ["All", "Done","Del"].map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );
              }).toList(),
              hint: Text('All',style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),),
              onChanged: (val) {
                print(val);
                 if(val=='All') {
                   setState(() {
                     workWith = 0;
                   });
                 }
                 else if(val=='Done')
                   {
                     setState(() {
                       workWith=1;
                     });
                   }
                 else
                   {
                     setState(() {
                       workWith=2;
                     });
                   }
              },
            ),
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Get.to(()=>const ItemAdd());
        },
      ),
      body: workWith==0?Obx(
            () => todoController.list.isNotEmpty?
            ListView.builder(
              itemCount: todoController.list.length,
             itemBuilder: (context, index) => Dismissible(

               key: UniqueKey(),
            background: Container(
              color: Colors.green,
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (_) {
                 if(_==DismissDirection.startToEnd)
                   {

                     todoController.finishedList.add(todoController.list[index]);
                     todoController.list.removeAt(index);
                     Get.snackbar('Finished', 'Completed Task Task',
                         icon: const Icon(Icons.check),
                         backgroundColor: Colors.green,
                         duration: const Duration(milliseconds: 700));
                   }
                 else {

                   todoController.deletedList.add(todoController.list[index]);
                   todoController.list.removeAt(index);
                   Get.snackbar('DELETE', 'Removed Task',
                       icon: const Icon(Icons.delete),
                       backgroundColor: Colors.redAccent,
                       duration: const Duration(milliseconds: 700));
                 }

            },

            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                  decoration: BoxDecoration(
                 border: Border.all(
                 color: Colors.purpleAccent.shade100, // Border color
                   width: 2.0, // Border width
                  ),
                borderRadius:const BorderRadius.all(Radius.circular(5.0))),
                child: ListTile(
                  title: Text(
                    todoController.list[index].title??' ',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    todoController.list[index].description??' ',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: ()
                    {
                      Get.to(()=>ItemEdit(index:index));
                    },
                  ),
          ),
              ),
            ),
        ),
      ):
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Swipe Right to Mark Task as Completed',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  Text(
                    'Swipe Left to Delete a Task',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            )
      ): (workWith==1?Obx(
              () => todoController.finishedList.isNotEmpty?
          ListView.builder(
            itemCount: todoController.finishedList.length,
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (_)
              {
                todoController.finishedList.removeAt(index);
              },
              key: UniqueKey(),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purpleAccent.shade100, // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius:const BorderRadius.all(Radius.circular(5.0))),
                  child: ListTile(
                    title: Text(
                      todoController.finishedList[index].title??' ',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      todoController.finishedList[index].description??' ',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: ()
                      {
                        Get.to(()=>ItemEdit(index:index));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ):
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Swipe Right to Remove Task Permannetly',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          )
      ):Obx(
              () => todoController.deletedList.isNotEmpty?
          ListView.builder(
            itemCount: todoController.deletedList.length,
            itemBuilder: (context, index) => Dismissible(

              key: UniqueKey(),
              background: Container(
                color: Colors.green,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) {
                todoController.deletedList.removeAt(index);
              },

              child: Padding(
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purpleAccent.shade100, // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius:const BorderRadius.all(Radius.circular(5.0))),
                  child: ListTile(
                    title: Text(
                      todoController.deletedList[index].title??' ',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      todoController.deletedList[index].description??' ',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: ()
                      {
                        Get.to(()=>ItemEdit(index:index));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ):
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Swipe Right to Delete permannetly',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),

              ],
            ),
          )
      )),
    );
  }
}
