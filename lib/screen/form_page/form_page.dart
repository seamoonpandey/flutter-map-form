import 'package:address_form/components/maps.dart';
import 'package:address_form/screen/form_page/form.dart';
import 'package:address_form/utils/functions/geocode.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // To store geocode data received from the map
  Map<String, String> geocodeData = {};

  _showMap() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Dialog.fullscreen(
              child: MoonMap(
                onLocationChanged: (LatLng location) async {
                  // Fetch geocode data using the location
                  decodeGeocode(location);
                  // Close the map after selecting the location
                  Navigator.of(context).pop();
                  setState(() {}); // Update the form with new geocode data
                },
              ),
            ),
          );
        });
  }

  _showAddressForm() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Dialog.fullscreen(
            child: AddressForm(
              openMap: _showMap,
              geocodeData: geocodeData, // Pass the geocode data to the form
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Form Page Content'),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: _showAddressForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
