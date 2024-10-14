import 'dart:io';

import 'package:fav_place_app/Models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);

  void add(String title,File image){
    final newPlace = Place(title: title, image: image);
    state = [newPlace,...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier,List<Place>>((ref)=>UserPlaceNotifier());