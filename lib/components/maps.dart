import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MoonMap extends StatefulWidget {
  final LatLng? initialLocation;
  final void Function(LatLng?) onLocationSelected;
  final LatLng? markerOn;

  const MoonMap({
    required this.onLocationSelected,
    this.initialLocation,
    this.markerOn,
    super.key,
  });

  @override
  _MoonMapState createState() => _MoonMapState();
}

class _MoonMapState extends State<MoonMap> with TickerProviderStateMixin {
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  final Geolocator geolocator = Geolocator();
  LatLng? currentLocation;
  LatLng? selectedLocation;

  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation == null) {
      _getCurrentLocation();
    } else {
      selectedLocation = widget.initialLocation;
    }
  }

  void _animatedMapMove(final LatLng destLocation, final double destZoom) {
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((final status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Future<void> _updateCurrentLocation() async {
    final Position currentPosition = await _determinePosition();
    setState(() {
      selectedLocation = currentLocation = LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      );
    });
    _animatedMapMove(currentLocation!, 14);
  }

  Future<void> _getCurrentLocation() async {
    final Position currentPosition = await _determinePosition();
    setState(() {
      currentLocation = LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      );
    });
    _animatedMapMove(currentLocation!, 14);
  }

  Future<Position> _determinePosition() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
      child: Dialog.fullscreen(
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: widget.initialLocation ??
                    currentLocation ??
                    const LatLng(27.7172, 85.3240),
                initialZoom: 12,
                onTap: (final point, final latLng) {
                  setState(() {
                    selectedLocation = latLng;
                    widget.onLocationSelected(selectedLocation);
                  });
                },
              ),
              mapController: mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    if (selectedLocation != null)
                      Marker(
                        point: selectedLocation!,
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.location_pin,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      )
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              left: (MediaQuery.of(context).size.width - 332) / 2,
              width: 332,
              height: 80,
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: () {
                      if (selectedLocation != null) {
                        setState(() {
                          currentLocation = selectedLocation;
                        });
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No location selected')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: Icon(Icons.location_pin,
                        color: Theme.of(context).primaryColor),
                    label: Text(
                      "Select Location",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )),
                  const SizedBox(
                    width: 32,
                  ),
                  IconButton(
                    onPressed: () {
                      _updateCurrentLocation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: const Icon(Icons.my_location, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
