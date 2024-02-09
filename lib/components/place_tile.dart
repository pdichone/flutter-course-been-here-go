import 'package:been_here_go/components/star_rating.dart';
import 'package:been_here_go/models/place.dart';
import 'package:flutter/material.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    // Unsplash image URL for placeholder
    const String unsplashPlaceholderUrl =
        'https://source.unsplash.com/random/800x600';
    return GestureDetector(
      onLongPress: () {
        // delete item
      },
      onTap: () => Navigator.pushNamed(context, '/details', arguments: place),
      child: Card(
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
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    unsplashPlaceholderUrl,
                    fit: BoxFit.cover,
                  ),
                )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color: Colors.white, fontSize: 16),
                                )
                              : const Text("") //12/45/234TTZsdadf
                        ],
                      ),
                      const Spacer(),
                      Text(
                        place.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      StarRating(rating: place.rating.toInt()),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
