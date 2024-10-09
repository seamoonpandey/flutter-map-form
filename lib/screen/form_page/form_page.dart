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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> geocodeData = {};

  final TextEditingController _addressTitleController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _cityTypeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _toleController = TextEditingController();
  final TextEditingController _wardNoController = TextEditingController();

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

              setState(() {
                // Ensure geocode data is properly assigned.
                geocodeData = data;

                _latitudeController.text = location.latitude.toString();
                _longitudeController.text = location.longitude.toString();
                _streetController.text =
                    geocodeData['Street'] ?? _streetController.text;
                _toleController.text =
                    geocodeData['Tole'] ?? _toleController.text;
                _cityController.text =
                    geocodeData['City'] ?? _cityController.text;
                _districtController.text =
                    geocodeData['District'] ?? _districtController.text;
                _provinceController.text =
                    geocodeData['Province'] ?? _provinceController.text;
                _countryController.text =
                    geocodeData['Country'] ?? _countryController.text;
                _wardNoController.text =
                    geocodeData['Ward No'] ?? _wardNoController.text;
                _cityTypeController.text =
                    geocodeData['City Type'] ?? _cityTypeController.text;
              });

              if (mounted) {
                Navigator.of(context).pop();
              }
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
            addressTitleController: _addressTitleController,
            cityController: _cityController,
            cityTypeController: _cityTypeController,
            countryController: _countryController,
            districtController: _districtController,
            emailController: _emailController,
            fullNameController: _fullNameController,
            latitudeController: _latitudeController,
            longitudeController: _longitudeController,
            phoneNoController: _phoneNoController,
            provinceController: _provinceController,
            streetController: _streetController,
            toleController: _toleController,
            wardNoController: _wardNoController,
            formKey: _formKey,
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
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
