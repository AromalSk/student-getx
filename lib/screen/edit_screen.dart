import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';

class EditScreen extends StatefulWidget {
  
 EditScreen({super.key, required this.id,required this.name,required this.age,required this.subject,required this.number,required this.images});
 final int id;
  String name;
  String age;
  String subject;
  String number;
  String images;
  


  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _nameControllerEdit = TextEditingController();

  final _ageControllerEdit = TextEditingController();

  final _subjectControllerEdit = TextEditingController();

  final _phoneControllerEdit = TextEditingController();

  File? image;
  

  @override
  Widget build(BuildContext context) {
    _nameControllerEdit.text=widget.name;
    _ageControllerEdit.text = widget.age;
    _subjectControllerEdit.text = widget.subject;
    _phoneControllerEdit.text = widget.number;


    


    return Scaffold(body: 
       SafeArea(
         child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(50),
                    child: ClipOval(child: 
                    image!= null ? Image.file(image!,width: 50,height: 50,fit: BoxFit.cover,) :
                    Image.asset('assets/images/personkoi.jpg',fit: BoxFit.cover,)
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
  final _name = _nameControllerEdit.text;
  final _age = _ageControllerEdit.text.trim();
  final _subject = _subjectControllerEdit.text.trim();
  final _phone = _phoneControllerEdit.text.trim();

 var value = StudentModel(name: _name, age: _age, subject: _subject, phone: _phone , image:image?.path ?? 'no-img' );
  await editStudent(widget.id, value);

}


   Future<void> showImage() async {
    final imagess =  await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagess ==null) {
      return;
    }

    final imageTemporary = File(imagess.path);
    setState(() {
    image = imageTemporary; 
    });
  }

}