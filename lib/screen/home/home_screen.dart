import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/screen/add_student_screen.dart';
import 'package:students_add/screen/home/widget/list_student_widget.dart';
import 'package:students_add/screen/home/widget/searchidle.dart';

//  ValueNotifier  searchScreenNotifier=ValueNotifier([]);
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  String text = '';
  StudentController myController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    myController.getallStudents();
 myController.getSearch();
    return Scaffold(
     
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child:  
           Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child:  
                    TextFormField(
                    controller: myController.searchController,
                    
                    onChanged: (value) { 
                     myController.searchingFieldOpen(true);
                    myController.searching(value);   
                    text = value;
                    },
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 18),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          myController.searchController.clear();
                           myController.searchingFieldOpen(false);
                        },
                      ),
                    ),
                      ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                
            Obx(() {
  return (myController.isSearching.value)
      ?
       Expanded(child: SearchIdle(query: text,)) : 
    
       Expanded(child: ListStudentWidget());
}),
          
          
              ],
            )       
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddStudentsScreen();
            }));
          }),
    );
  }
}
