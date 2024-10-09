import 'package:flutter/material.dart';

class AddressForm extends StatefulWidget {
  final void Function() openMap;
  final Map<String, String> geocodeData;

  // Controllers for each form field
  final TextEditingController addressTitleController;
  final TextEditingController cityController;
  final TextEditingController cityTypeController;
  final TextEditingController countryController;
  final TextEditingController districtController;
  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController phoneNoController;
  final TextEditingController provinceController;
  final TextEditingController streetController;
  final TextEditingController toleController;
  final TextEditingController wardNoController;

  final void Function() onSubmit;

  final GlobalKey<FormState>? formKey;

  const AddressForm({
    super.key,
    required this.onSubmit,
    required this.openMap,
    required this.geocodeData,
    required this.addressTitleController,
    required this.cityController,
    required this.cityTypeController,
    required this.countryController,
    required this.districtController,
    required this.emailController,
    required this.fullNameController,
    required this.latitudeController,
    required this.longitudeController,
    required this.phoneNoController,
    required this.provinceController,
    required this.streetController,
    required this.toleController,
    required this.wardNoController,
    required this.formKey,
  });

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  @override
  void initState() {
    super.initState();

    if (widget.geocodeData.isNotEmpty) {
      widget.cityController.text = widget.geocodeData['city'] ?? '';
      widget.countryController.text = widget.geocodeData['country'] ?? '';
      widget.streetController.text = widget.geocodeData['street'] ?? '';
      widget.latitudeController.text = widget.geocodeData['latitude'] ?? '';
      widget.longitudeController.text = widget.geocodeData['longitude'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: ListView(
          children: <Widget>[
            _buildTextField(widget.addressTitleController, 'Address Title'),
            _buildTextField(widget.cityController, 'City'),
            _buildTextField(widget.cityTypeController, 'City Type'),
            _buildTextField(widget.countryController, 'Country'),
            _buildTextField(widget.districtController, 'District'),
            _buildTextField(widget.emailController, 'Email',
                keyboardType: TextInputType.emailAddress),
            _buildTextField(widget.fullNameController, 'Full Name'),
            _buildTextField(widget.phoneNoController, 'Phone No',
                keyboardType: TextInputType.phone),
            _buildTextField(widget.provinceController, 'Province'),
            _buildTextField(widget.streetController, 'Street'),
            _buildTextField(widget.toleController, 'Tole'),
            _buildTextField(widget.wardNoController, 'Ward No'),
            const SizedBox(height: 20),
            TextButton(
              onPressed: widget.openMap,
              child: const Text(
                "Set on map",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onSubmit,
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
}
