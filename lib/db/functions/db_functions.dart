
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_add/db/models/data_model.dart';



class StudentController extends GetxController {

 final searchController = TextEditingController();

 RxBool isSearching = false.obs;
RxList studentList = <StudentModel>[].obs;
var filteredItems = <StudentModel>[].obs;


  RxString imagePath = ''.obs;
  RxBool isPicked = false.obs;

  RxString updateImagePath = ''.obs;
  RxBool isImageSelected = false.obs;

  void setPickedImage(String imgPath, bool isPick) {
    imagePath.value = imgPath;
    isPicked.value = isPick;
  }

    void updatePickedImage(String imgPath, bool isPick) {
    updateImagePath.value = imgPath;
    isImageSelected.value = isPick;
  }

    void searchingFieldOpen(bool isOpen) {
    isSearching.value = isOpen;
  }


getSearch(){
  getallStudents();
 return filteredItems.toList();
}

Future<void> addStudent(StudentModel value)async{
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
   getallStudents();
}


Future<void> getallStudents ()async{  
final studentDB = await Hive.openBox<StudentModel>('student_db');
studentList.clear();
studentList.addAll(studentDB.values);

}

Future<void> getallFiltered(String query) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  // Clear the existing items in the filteredItems list
  filteredItems.clear();

  // Add all the filtered values to the filteredItems list
  filteredItems.addAll(studentDB.values
      .where((student) => student.name.toLowerCase().contains(query.toLowerCase())));

  // You can return the filteredItems list if needed
  // return filteredItems.toList();
}


  Future<void> deleteStudent(int id)async{
  final studentDB =await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getallStudents();
   
}

Future<void> editStudent (int id,StudentModel value) async{
   final studentDB =await Hive.openBox<StudentModel>('student_db');
   await studentDB.put(id, value);
   getallStudents();
}



Future<List<StudentModel>> searching(String query) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  filteredItems.value = studentDB.values
      .where((student) => student.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return filteredItems.toList(); // Return the List<StudentModel> from RxList<StudentModel>
}

  void updateImage(String imagePath, bool isSelected) {
    updateImagePath.value = imagePath;
    isImageSelected.value = isSelected;
    update();
  }

}





