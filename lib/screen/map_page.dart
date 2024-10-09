import 'package:address_form/components/maps.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MoonMap(onLocationSelected: (LatLng? location) {}),
    );
  }
}
