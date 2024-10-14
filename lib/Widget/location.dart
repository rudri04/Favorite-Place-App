import 'package:flutter/material.dart';
import 'package:location/location.dart';
class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? pickedLocation;
  var isLoadingLocation = false;


  void getCurrentLocation() async{
    Location location =Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isLoadingLocation = true;
    });

    locationData = await location.getLocation();
    setState(() {
      isLoadingLocation = false;
    });
    print(locationData.latitude);
    print(locationData.longitude);
  }


  @override
  Widget build(BuildContext context) {
    Widget previewContent =  Center(
      child: Text('No Location Chosen',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),),
    );

    if(isLoadingLocation){
      previewContent = const Center(child: CircularProgressIndicator(),);
    }


    return  Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
          ),
          child:previewContent
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: getCurrentLocation, label: const Text('Get Current Location'),icon: const Icon(Icons.location_on),),
            TextButton.icon(onPressed: (){}, label: const Text('Select on Map'),icon: const Icon(Icons.map),)
          ],
        )
      ],
    );
  }
}
