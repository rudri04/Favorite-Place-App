import 'dart:io';

import 'package:fav_place_app/Providers/user_places.dart';
import 'package:fav_place_app/Widget/image.dart';
import 'package:fav_place_app/Widget/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void savePlace(){
    final enteredText = _titleController.text;

    if(_titleController.text == '' || _selectedImage == null){
      return;
    }
    ref .read(userPlaceProvider.notifier)
        .add(enteredText,_selectedImage!);
    Get.back();
  }


  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
             ImageInput(onPickedFile:(image){
                _selectedImage = image;
            }),
            const SizedBox(height: 16),
            const LocationInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}