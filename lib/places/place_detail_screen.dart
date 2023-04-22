import 'package:flutter/material.dart';
import 'package:my_favorite_places/screens/map_screen.dart';

import 'package:provider/provider.dart';

import '../providers/my_fav_places.dart';

class PlaceDetailScreen extends StatefulWidget {
  static const routeName = '/place-detail-screen';

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace = Provider.of<MyFavoritePlaces>(context).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.placeName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: selectedPlace.id,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            selectedPlace.placeName,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            selectedPlace.location!.address!,
            style: const TextStyle(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => MapScreen(), fullscreenDialog: true),
              );
            },
            icon: const Icon(Icons.map),
            label: const Text('Show on map.'),
          )
        ],
      ),
    );
  }
}
