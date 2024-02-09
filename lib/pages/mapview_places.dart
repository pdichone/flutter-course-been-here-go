import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesMapView extends StatefulWidget {
  const PlacesMapView({super.key});

  @override
  State<PlacesMapView> createState() => _PlacesMapViewState();
}

class _PlacesMapViewState extends State<PlacesMapView> {
  late GoogleMapController? mapController;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    const center = LatLng(0.0, 0.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places You\'ve Been'),
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              const CameraPosition(target: center, zoom: 10)),
    );
  }
}
