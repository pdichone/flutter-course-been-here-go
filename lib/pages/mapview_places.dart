import 'package:flutter/material.dart';

class PlacesMapView extends StatefulWidget {
  const PlacesMapView({super.key});

  @override
  State<PlacesMapView> createState() => _PlacesMapViewState();
}

class _PlacesMapViewState extends State<PlacesMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places You\'ve Been'),
      ),
    );
  }
}
