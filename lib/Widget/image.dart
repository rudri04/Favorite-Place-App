import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickedFile});
  final void Function(File image) onPickedFile;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void takePicture() async{
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);
    if(pickedImage == null){
      return;
    }
    setState(() {
    selectedImage = File(pickedImage.path,);
    });

    widget.onPickedFile(selectedImage!);
  }
  @override
  Widget build(BuildContext context) {
    Widget content =  TextButton.icon(
      onPressed:takePicture,
      label: const Text('Take Picture',),
      icon: const Icon(Icons.camera_alt),
    );

    if(selectedImage != null){
      content = GestureDetector(
          onTap: takePicture,
          child: Image.file(selectedImage!,fit: BoxFit.cover,width: double.infinity,height: double.infinity,));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child:content
    );
  }
}
