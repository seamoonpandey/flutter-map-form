import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MoonMap extends StatefulWidget {
  const MoonMap({super.key});

  @override
  State<MoonMap> createState() => _MoonMapState();
}

class _MoonMapState extends State<MoonMap> {
  final MapController _mapController = MapController();
  double latitude = 27.7172;
  double longitude = 85.3240;

  late final MapOptions _mapOptions;

  @override
  void initState() {
    super.initState();
    _mapOptions = MapOptions(
      initialCenter: LatLng(latitude, longitude),
      initialZoom: 13.0,
      interactionOptions: const InteractionOptions(
        flags: InteractiveFlag.all,
      ),
      onTap: (tapPosition, point) {
        setState(() {
          latitude = point.latitude;
          longitude = point.longitude;
        });
      },
    );
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return Future.error('Location permissions are permanently denied');
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
      ),
    );

    setState(() {
      longitude = position.longitude;
      latitude = position.latitude;
    });

    // Move the map to the current location
    _mapController.move(LatLng(latitude, longitude), 13.0);
  }

  void _goToCurrentLocation() {
    _mapController.move(LatLng(latitude, longitude), 13.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: _mapOptions,
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude, longitude),
                  child: const Icon(
                    Icons.location_on,
                    size: 48.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: _goToCurrentLocation,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
