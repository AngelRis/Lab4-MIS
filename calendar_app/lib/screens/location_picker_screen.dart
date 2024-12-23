import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избери Локација',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        actions: [
          if (_pickedLocation != null)
            IconButton(
              icon: const Icon(Icons.check,color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.9981, 21.4254), // Скопје, Македонија
          zoom: 13,
        ),
        onTap: _selectLocation,
        markers: _pickedLocation == null
            ? {}
            : {
          Marker(
            markerId: const MarkerId('selected-location'),
            position: _pickedLocation!,
          ),
        },
      ),
    );
  }
}
