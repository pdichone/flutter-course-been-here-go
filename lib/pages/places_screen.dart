import 'package:been_here_go/models/place.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:been_here_go/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).user!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
      ),
      body: Consumer<PlacesProvider>(
        builder: (context, value, child) {
          final places = value.fetchPlaces(userId);
          return FutureBuilder<List<Place>>(
            future: places,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final places = snapshot.data!;

                if (places.isEmpty) {
                  return const Center(
                    child: Text('No places Found'),
                  );
                }

                // all is good
                return ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(places[index].name),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No places found'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
