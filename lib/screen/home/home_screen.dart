import 'package:flutter/material.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/screen/add_student_screen.dart';
import 'package:students_add/screen/home/widget/list_student_widget.dart';
import 'package:students_add/screen/home/widget/searchidle.dart';

  final _searchController = TextEditingController();
  
   ValueNotifier  searchScreenNotifier=ValueNotifier([]);
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
  
    getallStudents();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
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
              child: TextFormField(
                 controller: _searchController,
              onChanged: (value) {
                setState(() {
                searchScreenNotifier.notifyListeners();
                search(value);
           
                });
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
                    _searchController.clear();
                  },
                  
                ),
              ),
                ),
            ),
              ),
            SizedBox(
              height: 15,
            ),
            (_searchController.text.isEmpty) ?
            Expanded(child: ListStudentWidget()):
            Expanded(child: SearchIdle())
            
          ],
        ),
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
