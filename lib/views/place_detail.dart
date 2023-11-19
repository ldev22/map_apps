import 'package:flutter/material.dart';
import 'package:maps/models/Place.dart';
import 'package:maps/views/map.dart';

class PlaceDetailView extends StatelessWidget {
  const PlaceDetailView({super.key, required this.place});
  final Place place;

  final String apiKey = 'AIzaSyB9RFY4biNIDW4B-OwDw_0LOXj5nbkxUPk';

  String get locationImage {
    final lat = place.location.latitude;
    final lon = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center={$lat},${lon}=&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:S%7C{$lat},{$lon}&key={$apiKey}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => MapView(
                        location: place.location,
                        isSelecting: false,
                      ),
                    ));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
