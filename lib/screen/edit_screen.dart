import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';

class EditScreen extends StatelessWidget {
  
 EditScreen({super.key, required this.id,required this.name,required this.age,required this.subject,required this.number,required this.images});
 final int id;
  String name;
  String age;
  String subject;
  String number;
  String images;
  

 StudentController myStudent = Get.put(StudentController());
  final _nameControllerEdit = TextEditingController();

  final _ageControllerEdit = TextEditingController();

  final _subjectControllerEdit = TextEditingController();

  final _phoneControllerEdit = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {

     myStudent.setPickedImage('', false);
    _nameControllerEdit.text=name;
    _ageControllerEdit.text = age;
    _subjectControllerEdit.text = subject;
    _phoneControllerEdit.text = number;
    myStudent.updateImage(images, false);

 File img = File(images);
    


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: 
       SafeArea(
        
         child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                 pickImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(50),
                    child: ClipOval(child: 
                   Obx(() {
                     if (myStudent.isImageSelected.value) {
                       File? updateimg = File(myStudent.updateImagePath.value);
                       return Image.file(updateimg,fit: BoxFit.cover,);
                     }else{
                      if (myStudent.updateImagePath.value == '') {
                        return Image.asset('assets/images/personkoi.jpg',fit: BoxFit.cover,);
                      }else{
                        File? updateimg = File(myStudent.updateImagePath.value);
                       return Image.file(updateimg,fit: BoxFit.cover,);
                      }
                     }
                   },)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _nameControllerEdit,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), hintText: 'Name'),
              ),
              const SizedBox(
                height: 15,
              ),
               TextFormField(
                keyboardType: TextInputType.number,
                controller: _ageControllerEdit,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), hintText: 'Age'),
              ),
               const SizedBox(
                height: 15,
              ),
               TextFormField(
                controller: _subjectControllerEdit,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), hintText: 'Subject'),
              ),
              const SizedBox(
                height: 15,
              ),
               TextFormField(
                controller: _phoneControllerEdit,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), hintText: 'Phone number'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: (){
                onUpdate(context);
                Navigator.of(context).pop();
              }, child: const Text('Update'))
              
            ],
           
          ),
             ),
       ),
    );
  }

  Future<void> onUpdate(BuildContext context) async {
    StudentController myController = Get.put(StudentController());
    
  final _name = _nameControllerEdit.text;
  final _age = _ageControllerEdit.text.trim();
  final _subject = _subjectControllerEdit.text.trim();
  final _phone = _phoneControllerEdit.text.trim();

 var value = StudentModel(name: _name, age: _age, subject: _subject, phone: _phone , image: myStudent.updateImagePath.value == ''
                                  ? images
                                  : myStudent.updateImagePath.value,);
  await myController.editStudent(id, value);
}

  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      myStudent.updateImage(imagePicked.path, true);
    }
  }
}