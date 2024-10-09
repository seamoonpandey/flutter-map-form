import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

Future<Map<String, String>> decodeGeocode(LatLng location) async {
  final String url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}&zoom=18&addressdetails=1&accept-language=en';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return mapGeocodeData(location, data);
    } else {
      debugPrint('Failed to get address. Status code: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
    return {};
  }
}

Map<String, String> mapGeocodeData(LatLng location, Map<String, dynamic> data) {
  final address = data['address'] ?? {};

  String road = address['road'] ?? '';
  String city = address['city'] ?? address['town'] ?? address['village'] ?? '';
  String district = address['county'] ?? '';
  String province = address['state'] ?? '';
  String country = address['country'] ?? '';
  String postalCode = address['postcode'] ?? '';
  String latitude = location.latitude.toString();
  String longitude = location.longitude.toString();
  String cityType = address['type'] ?? '';
  String street = road;
  String wardNo = address['neighbourhood'] ?? '';
  String tole = address['suburb'] ?? '';

  return {
    'Street': street,
    'Tole': tole,
    'City': city,
    'District': district,
    'Province': province,
    'Country': country,
    'Postal Code': postalCode,
    'Ward No': wardNo,
    'City Type': cityType,
    'Latitude': latitude,
    'Longitude': longitude,
  };
}
