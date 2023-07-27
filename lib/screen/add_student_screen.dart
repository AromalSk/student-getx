import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:students_add/screen/home/widget/add_student_widget.dart';

class AddStudentsScreen extends StatelessWidget {
  const AddStudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            AddStudentWidget(),
          ],
        ),
      )),
    );
  }
}