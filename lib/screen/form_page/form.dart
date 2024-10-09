import 'package:address_form/models/address.dart';
import 'package:address_form/utils/functions/print_address.dart';
import 'package:flutter/material.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each form field
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildTextField(_addressTitleController, 'Address Title'),
            _buildTextField(_cityController, 'City'),
            _buildTextField(_cityTypeController, 'City Type'),
            _buildTextField(_countryController, 'Country'),
            _buildTextField(_districtController, 'District'),
            _buildTextField(_emailController, 'Email',
                keyboardType: TextInputType.emailAddress),
            _buildTextField(_fullNameController, 'Full Name'),
            _buildTextField(_latitudeController, 'Latitude'),
            _buildTextField(_longitudeController, 'Longitude'),
            _buildTextField(_phoneNoController, 'Phone No',
                keyboardType: TextInputType.phone),
            _buildTextField(_provinceController, 'Province'),
            _buildTextField(_streetController, 'Street'),
            _buildTextField(_toleController, 'Tole'),
            _buildTextField(_wardNoController, 'Ward No'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint('Form is valid');
                  printAddress(Address(
                    addressTitle: _addressTitleController.text,
                    city: _cityController.text,
                    cityType: _cityTypeController.text,
                    country: _countryController.text,
                    district: _districtController.text,
                    email: _emailController.text,
                    fullName: _fullNameController.text,
                    latitude: _latitudeController.text,
                    longitude: _longitudeController.text,
                    phoneNo: _phoneNoController.text,
                    province: _provinceController.text,
                    street: _streetController.text,
                    tole: _toleController.text,
                    wardNo: _wardNoController.text,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _addressTitleController.dispose();
    _cityController.dispose();
    _cityTypeController.dispose();
    _countryController.dispose();
    _districtController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _phoneNoController.dispose();
    _provinceController.dispose();
    _streetController.dispose();
    _toleController.dispose();
    _wardNoController.dispose();
    super.dispose();
  }
}
