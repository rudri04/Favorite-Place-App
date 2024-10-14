import 'package:fav_place_app/View/placeDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/place.dart';
class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.places});
  final List<Place> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: FileImage(places[index].image),
        ),
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onTap: ()=>Get.to(()=>PlaceDetail(place: places[index])),
      ),
    );
  }

}

