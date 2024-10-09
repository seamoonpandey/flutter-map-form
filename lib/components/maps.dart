import 'package:address_form/utils/functions/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MoonMap extends StatefulWidget {
  final ValueChanged<LatLng> onLocationChanged;
  final ValueChanged<LatLng> onLocationConfirmed;
  const MoonMap({
    required this.onLocationChanged,
    required this.onLocationConfirmed,
    super.key,
  });

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
          widget.onLocationChanged(LatLng(latitude, longitude));
        });
      },
    );
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    if (!await isLocationServiceEnabled()) return;

    LocationPermission permission = await checkAndRequestLocationPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) return;

    Position? position = await fetchCurrentPosition();
    setState(() {
      if (position != null) {
        longitude = position.longitude;
        latitude = position.latitude;
      }
      widget.onLocationChanged(LatLng(latitude, longitude));
    });

    _mapController.move(LatLng(latitude, longitude), 13.0);
  }

  void _getCurrentLocation() async {
    Position? position = await fetchCurrentPosition();
    setState(() {
      if (position != null) {
        longitude = position.longitude;
        latitude = position.latitude;
      }
      widget.onLocationChanged(LatLng(latitude, longitude));
    });

    _goToCurrentLocation();
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: _getCurrentLocation,
                child: const Icon(Icons.my_location),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () =>
                    widget.onLocationConfirmed(LatLng(latitude, longitude)),
                child: const Text('Confirm Location'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
