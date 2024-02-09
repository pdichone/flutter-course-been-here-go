import 'package:been_here_go/components/star_rating.dart';
import 'package:been_here_go/models/place.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:been_here_go/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
// Unsplash image URL for placeholder
    const String unsplashPlaceholderUrl =
        'https://source.unsplash.com/random/800x600';
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
                // return ListView.builder(
                //   itemCount: places.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(places[index].name),
                //     );
                //   },
                // );
                return GridView.custom(
                  gridDelegate: SliverStairedGridDelegate(
                    crossAxisSpacing: 48,
                    mainAxisSpacing: 24,
                    startCrossAxisDirectionReversed: true,
                    pattern: [
                      StairedGridTile(0.5, 1),
                      StairedGridTile(0.5, 3 / 4),
                      StairedGridTile(1.0, 10 / 4),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: places.length,
                    (context, index) {
                      final place = places[index];
                      return Card(
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Positioned.fill(
                                    child: Image.network(
                                  place.imageUrl ?? unsplashPlaceholderUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                    unsplashPlaceholderUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      OverflowBar(
                                        spacing: 8,
                                        children: [
                                          place.createdAt != null
                                              ? Text(
                                                  place.createdAt!
                                                      .toDate()
                                                      .toIso8601String()
                                                      .split('T')[0],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )
                                              : const Text(
                                                  "") //12/45/234TTZsdadf
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        place.name,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      StarRating(rating: place.rating.toInt()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ),
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
