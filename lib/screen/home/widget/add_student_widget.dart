
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';
import 'package:students_add/screen/home/home_screen.dart';


class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({Key? key}) : super(key: key);

 StudentController myStudent = Get.put(StudentController());


  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _subjectController = TextEditingController();

  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 150,),
            GestureDetector(
              onTap: () {
                
                pickImage();
              },
              child:
                CircleAvatar(
                  radius: 50,
                  child: 
                  SizedBox.fromSize(
                    size: Size.fromRadius(50),
                    child:
                    
                     ClipOval(
                        child:
                        Obx(() {
                            File img = File(myStudent.imagePath.value);
                         if (myStudent.isPicked.value == true) {
                           return  Image.file(
                             img,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              );
                         }  else{
                          return Image.asset(
                                'assets/images/personkoi.jpg',
                                fit: BoxFit.cover,
                              );
                         }
                        
                              //  if (myStudent.isPicked.value) {
                              //   File img =
                              //       File(myStudent.imagePath.value);
                              //   return Image.file(img);
                              // } else {
                              //   return Image.asset('assets/images/personkoi.jpg');
                              // }
                         
                        },)
                       ),
                  ),
                )
           )
                 
        ,
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Age'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Subject'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              
              controller: _phoneController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Phone number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This needs to be filled';
                }else if(value.length<10 || value.length > 10 ){
                  return 'Invalid number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                 
                  if (_formKey.currentState!.validate()) {
                    onAddStudentButtonClicked();
                    myStudent.getallStudents();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return 
                      HomeScreen();
                    },));
                     
                  }
                },
                child: const Text('Click to save'))
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
   
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _subject = _subjectController.text.trim();
    final _phone = _phoneController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _subject.isEmpty || _phone.isEmpty) {
      return;
    } else {
      var _student = StudentModel(
          name: _name,
          age: _age,
          subject: _subject,
          phone: _phone,
          image:  myStudent.imagePath.value);
     myStudent.addStudent(_student);
    }
  }

  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      myStudent.setPickedImage(imagePicked.path, true);
    }
  }




}

