import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';
import 'package:students_add/screen/details_screen.dart';
import 'package:students_add/screen/edit_screen.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final controllerdot = Get.find<StudentController>();
    
    return GetX<StudentController>(
      builder: (controller) {
        controllerdot.getallStudents();
        
        var studentList = controller.studentList;
        
        return ListView.separated(
        itemBuilder: (ctx, index) {
          final data = studentList[index];
          File? image;
          if (data.image != '') {
            image = File(data.image);
          }
          return ListTile(
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return DetailsScreen(
                name: data.name,
                age: data.age,
               subject: data.subject,
               phone: data.phone,
               images: data.image,
              );
            })),
            leading: CircleAvatar(
              radius: 30,
              child:SizedBox.fromSize(
                size:  Size.fromRadius(30),
                child: ClipOval(
                  child: (image != null)
              ? Image.file(image,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
              )
              : Image.asset('assets/images/personkoi.jpg',fit: BoxFit.cover,),
            ),
                ),
              ),
              
            title: Obx(() => Text(controllerdot.studentList[index].name)),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return EditScreen(name: data.name,age: data.age,subject: data.subject, number: data.phone,id: data.key,images: data.image,);
                    }));
                  }, icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {
                      if (data.key != null) {
                        try {
                        controllerdot.deleteStudent(data.key!);
                        } catch (e) {
                          print('Failed to delete student: $e');
                        }
                      } else {
                        print("data id is null");
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) => const Divider(),
        itemCount:controllerdot.studentList.length,
        
      );
      
      },
      
    );
  }
}
