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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO LIST'),
        centerTitle: true,

      ),
      // drawer: Drawer(
      //   child:  Column(
      //     children: [
      //       SizedBox(height: 10,),
      //       Container(
      //         decoration: BoxDecoration(
      //             border: Border.all(
      //               color: Colors.purpleAccent.shade100, // Border color
      //               width: 2.0, // Border width
      //             ),
      //             borderRadius:const BorderRadius.all(Radius.circular(5.0))),
      //         child: ListTile(
      //           onTap: ()
      //           {
      //               Get.back();
      //           },
      //           title: Text('View All Tasks'),
      //         ),
      //       ),
      //       SizedBox(height: 10,),
      //       Container(
      //         decoration: BoxDecoration(
      //             border: Border.all(
      //               color: Colors.purpleAccent.shade100, // Border color
      //               width: 2.0, // Border width
      //             ),
      //             borderRadius:const BorderRadius.all(Radius.circular(5.0))),
      //         child: ListTile(
      //           onTap: ()
      //           {
      //             Get.back();
      //           },
      //           title: Text('View Finished Tasks'),
      //         ),
      //       ),
      //       SizedBox(height: 10,),
      //       Container(
      //         decoration: BoxDecoration(
      //             border: Border.all(
      //               color: Colors.purpleAccent.shade100, // Border color
      //               width: 2.0, // Border width
      //             ),
      //             borderRadius:const BorderRadius.all(Radius.circular(5.0))),
      //         child: ListTile(
      //           onTap: ()
      //           {
      //             Get.back();
      //           },
      //           title: Text('View Removed Tasks'),
      //         ),
      //       ),
      //       SizedBox(height: 10,),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Get.to(()=>const ItemAdd());
        },
      ),
      body: Obx(
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
                     todoController.list.removeAt(index);
                     todoController.finishedList.add(todoController.list[index]);
                     Get.snackbar('Finished', 'Completed Task Task',
                         icon: const Icon(Icons.check),
                         backgroundColor: Colors.green,
                         duration: const Duration(milliseconds: 700));
                   }
                 else {
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
      ),
    );
  }
}
