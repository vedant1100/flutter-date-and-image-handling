import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class datetimepicker extends StatefulWidget {
  const datetimepicker({super.key});

  @override
  State<datetimepicker> createState() => _datetimepickerState();
}

class _datetimepickerState extends State<datetimepicker> {
  TextEditingController dateTime=TextEditingController();
  File? selectedImage;
  File? imageSelected;

  Future<void> selectDate() async{
    DateTime? isFilled= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now()
    );

    if(isFilled!=null){
      setState(() {
        dateTime.text=isFilled.toString().split(' ')[0];
      });
    }
  }

  Future<void> selectImageFromGallery() async{
    final galleryImage=await ImagePicker().pickImage(source: ImageSource.gallery);

    if(galleryImage==null)
      return;

    setState(() {
      selectedImage=File(galleryImage.path);
    });
  }

  Future<void> selectImageFromCamera() async{
    final cameraImage=await ImagePicker().pickImage(source: ImageSource.camera);

    if(cameraImage==null)
      return;

    setState(() {
      imageSelected=File(cameraImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              TextField(
                controller: dateTime,
                decoration: const InputDecoration(labelText: 'Date'),
                onTap: (){
                  selectDate();
                },
              ),
              ElevatedButton(
                  onPressed: (){
                    selectImageFromGallery();
                  },
                  child: const Text('Pick Image from Gallery')
              ),
              SizedBox(height: 200,width: MediaQuery.of(context).size.width,
                child:selectedImage!=null ? Image.file(selectedImage!):const Text('enter data'),
              ),
              ElevatedButton(
                  onPressed: (){
                    selectImageFromCamera();
                  },
                  child: const Text('Pick Image from Camera')
              ),
              SizedBox(height: 200,width: MediaQuery.of(context).size.width,
                child:imageSelected!=null ? Image.file(imageSelected!):const Text('enter data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


