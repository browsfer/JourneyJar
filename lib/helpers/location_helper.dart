import 'google_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationHelper {
  static String generateLocationPreview(
      {required double? latitude, required double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,-$longitude&key=$apiKey';
  }

  static Future<String> getLocationAddress({
    required double? latitude,
    required double? longitude,
  }) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
