import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailsScreen extends StatelessWidget {
  
  String name;
  String age;
  String phone;
  String subject;
  String images;
  DetailsScreen({super.key,required this.name,required this.age,required this.phone,required this.subject,required this .images});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(125, 126, 150, 0.922),
      body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
                radius: 100,
                child:SizedBox.fromSize(
                  size:  Size.fromRadius(90),
                  child: ClipOval(
                    child: (images != 'no-img')
                ? Image.file(File(images),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                )
                : Image.asset('assets/images/personkoi.jpg',fit: BoxFit.cover,),
              ),
                  ),
                ),
                SizedBox(height: 15,),
          Text('Name : $name',style: TextStyle(fontSize: 20),),
          Text('Age : $age',style: TextStyle(fontSize: 20),),
          Text('Subject : $subject',style: TextStyle(fontSize: 20),),
          Text('Phone : $phone',style: TextStyle(fontSize: 20),),
        
        ],
       ),
      ),
    );
  }
}