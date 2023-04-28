import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

import '../places/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function? selectLocation;

  const LocationInput(this.selectLocation, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void getMapImage(double? lat, double? lng) {
    final staticMapUrl = LocationHelper.generateLocationPreview(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapUrl;
    });

    widget.selectLocation!(lat, lng);
  }

  Future<void> getCurrentLocation() async {
    try {
      final currentLocation = await Location().getLocation();
      getMapImage(currentLocation.latitude, currentLocation.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> selectLocation() async {
    try {
      final selectLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => MapScreen(isSelecting: true),
        ),
      );
      getMapImage(selectLocation?.latitude, selectLocation?.longitude);
    } catch (error) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl != null && _previewImageUrl!.isNotEmpty
              ? Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Center(
                  child: Text(
                    'No image loaded.',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Use my current location.'),
            ),
            TextButton.icon(
              onPressed: selectLocation,
              icon: const Icon(Icons.map),
              label: const Text('Choose on map.'),
            ),
          ],
        )
      ],
    );
  }
}
