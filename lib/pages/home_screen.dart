import 'dart:io';

import 'package:been_here_go/components/add_place_form.dart';
import 'package:been_here_go/components/camera_button.dart';
import 'package:been_here_go/components/location_info.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:been_here_go/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _selectedImage;
  LocationData? _position;
  String _address = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddress();
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final XFile? imageFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 450);

    if (imageFile == null) {
      return;
    }

    setState(() {
      _selectedImage = imageFile;
    });
  }

  Future<LocationData?> _getCurrentLocation() async {
    return await Provider.of<LocationProvider>(context, listen: false)
        .getCurrentLocation();
  }

  Future<String> getAddressFromLatLon(LocationData position) async {
    // Geocoding
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude!, position.longitude!);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String address =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

        return address;
      } else {
        return 'No address available';
      }
    } catch (e) {
      return 'Error  $e';
    }
  }

  Future<void> _getAddress() async {
    LocationData? locatioData = await _getCurrentLocation();
    if (locatioData != null) {
      // get the address from lat and lon
      String address = await getAddressFromLatLon(locatioData);

      setState(() {
        _position = locatioData;
        _address = address;
      });
    } else {
      print('Failed to fetch data!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // bodyContent
    Widget bodyContent;
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text('Take a Picture'));

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.file(
            File(_selectedImage!.path),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (_position != null) {
      {
        bodyContent = Column(
          children: [
            LocationInfo(address: _address),
            CameraButton(content: content),
            AddPlaceFrom(
              latitude: _position!.latitude.toString(),
              longitude: _position!.longitude.toString(),
              currentAddress: _address,
            )
          ],
        );
      }
    } else {
      bodyContent = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('BeenHere'),
      ),
      body: SingleChildScrollView(
        child: bodyContent,
      ),
    );
  }
}
