import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

void decodeGeocode(LatLng location) async {
  final String url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}&zoom=18&addressdetails=1&accept-language=en';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Extracting relevant address information from the response
      String road = data['address']['road'] ?? 'Unknown road';
      String city = data['address']['city'] ??
          data['address']['town'] ??
          data['address']['village'] ??
          'Unknown city';
      String district = data['address']['county'] ?? 'Unknown district';
      String province = data['address']['state'] ?? 'Unknown province';
      String country = data['address']['country'] ?? 'Unknown country';
      String postalCode = data['address']['postcode'] ?? 'Unknown postal code';
      String latitude = location.latitude.toString();
      String longitude = location.longitude.toString();
      String cityType = data['address']['type'] ?? 'Unknown city type';
      String street = road;
      String wardNo = data['address']['neighbourhood'] ?? 'Unknown ward';
      String tole = data['address']['suburb'] ?? 'Unknown suburb';

      debugPrint('Street: $street');
      debugPrint('Tole: $tole');
      debugPrint('City: $city');
      debugPrint('District: $district');
      debugPrint('Province: $province');
      debugPrint('Country: $country');
      debugPrint('Postal Code: $postalCode');
      debugPrint('Ward No: $wardNo');
      debugPrint('City Type: $cityType');
      debugPrint('Latitude: $latitude');
      debugPrint('Longitude: $longitude');
    } else {
      debugPrint('Failed to get address. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
  }
}
