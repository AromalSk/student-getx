import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_add/db/adapter/database_adapter.dart';
import 'package:students_add/db/adapter/hiveservice.dart';

class ImageCheck extends StatefulWidget {
  const ImageCheck({super.key});

  @override
  State<ImageCheck> createState() => _ImageCheckState();
}

class _ImageCheckState extends State<ImageCheck> {
  DatabaseAdapter adapter = HiveService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Uint8List>?>(
          future: _readImagesFromDatabase(),
          builder: (context, AsyncSnapshot<List<Uint8List>?> snapshot) {
            if (snapshot.hasError) {
              return Text("Error appeared ${snapshot.error}");
            }
           if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text("Nothing to show");
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    Image.memory(snapshot.data![index]),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );            
          },
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
    );
  }

  Future<List<Uint8List>?> _readImagesFromDatabase() async {
    return adapter.getImages();
  }

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    Uint8List imageBytes =  await image.readAsBytes();
     
  }
}
