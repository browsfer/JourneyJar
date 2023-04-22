import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_favorite_places/helpers/location_helper.dart';
import '../helpers/db_helper.dart';

import '../models/place.dart';

class MyFavoritePlaces extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    File image,
    String placeName,
    PlaceLocation? pickedLocation,
    String? userNotes,
  ) async {
    final address = await LocationHelper.getLocationAddress(
      latitude: pickedLocation?.latitude,
      longitude: pickedLocation?.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation?.latitude,
      longitude: pickedLocation?.longitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        placeName: placeName,
        image: image,
        location: updatedLocation,
        notes: userNotes);
    _items.insert(0, newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'placeName': newPlace.placeName,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address,
      'userNotes': newPlace.notes,
    });
  }

  Future<void> fetchPlaces() async {
    final dbData = await DBHelper.getData('user_places');
    _items = dbData
        .map(
          (val) => Place(
              id: val['id'],
              placeName: val['placeName'],
              image: File(val['image'] as String),
              location: PlaceLocation(
                latitude: val['loc_lat'],
                longitude: val['loc_lng'],
                address: val['address'],
              )),
        )
        .toList();
    notifyListeners();
  }
}
