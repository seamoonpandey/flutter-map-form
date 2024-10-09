import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<bool> isLocationServiceEnabled() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showLocationServicesDialog();
    return false;
  }
  return true;
}

Future<LocationPermission> checkAndRequestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showError('Location permissions are denied.');
      return permission;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    showError('Location permissions are permanently denied.');
    return permission;
  }

  return permission;
}

Future<Position?> fetchCurrentPosition() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
      ),
    );
    return position;
  } catch (e) {
    showError('Failed to get current location.');
    return null;
  }
}

void showLocationServicesDialog() {
  showDialog(
    context: navigatorKey.currentState!.context,
    builder: (context) => AlertDialog(
      title: const Text('Location Services Disabled'),
      content: const Text('Please enable location services to use the map.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Geolocator.openLocationSettings();
          },
          child: const Text('Open Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}

void showError(String message) {
  scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
