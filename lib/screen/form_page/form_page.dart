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
  Map<String, String> geocodeData = {};

  _showMap() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: MoonMap(
            onLocationChanged: (LatLng location) async {
              setState(() {});
            },
            onLocationConfirmed: (LatLng location) async {
              Map<String, String> data = await decodeGeocode(location);

              debugPrint('Geocode data: $data');
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  _showAddressForm() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.zero,
          ),
          child: AddressForm(
            openMap: _showMap,
            geocodeData: geocodeData,
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
