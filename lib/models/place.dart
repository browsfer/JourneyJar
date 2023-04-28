import 'dart:io';
import 'package:flutter/material.dart';

class PlaceLocation {
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
}

class Place extends ChangeNotifier {
  final String id;
  final String placeName;
  final PlaceLocation? location;
  final File image;
  final String notes;

  Place(
      {required this.id,
      required this.placeName,
      this.location,
      required this.image,
      required this.notes});
}
