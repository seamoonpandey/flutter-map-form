import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

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

  Widget buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required Icon prefixIcon,
    String? hintText,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
          label: Text(labelText),
        ),
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  Widget buildTwoTextFormFieldRow({
    required TextEditingController controller1,
    required String label1,
    required Icon icon1,
    required TextEditingController controller2,
    required String label2,
    required Icon icon2,
    String? hintText1,
    String? hintText2,
    required String? Function(String?) validator1,
    required String? Function(String?) validator2,
  }) {
    return Row(
      children: [
        Expanded(
          child: buildTextFormField(
            controller: controller1,
            labelText: label1,
            prefixIcon: icon1,
            hintText: hintText1,
            validator: validator1,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: buildTextFormField(
            controller: controller2,
            labelText: label2,
            prefixIcon: icon2,
            hintText: hintText2,
            validator: validator2,
          ),
        ),
      ],
    );
  }

  String? requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              'Add new address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            buildTextFormField(
              controller: widget.addressTitleController,
              labelText: 'Address Title',
              prefixIcon: const Icon(Icons.list_alt_outlined),
              hintText: 'Home, Office, etc.',
              validator: requiredFieldValidator,
            ),
            buildTextFormField(
              controller: widget.fullNameController,
              labelText: 'Name',
              prefixIcon: const Icon(Iconsax.user),
              validator: requiredFieldValidator,
            ),
            buildTextFormField(
              controller: widget.emailController,
              labelText: 'Email',
              prefixIcon: const Icon(FontAwesomeIcons.envelope),
              hintText: 'yourmail@example.com',
              validator: emailValidator,
            ),
            buildTextFormField(
              controller: widget.phoneNoController,
              labelText: 'Phone Number',
              prefixIcon: const Icon(Iconsax.mobile),
              hintText: '98********',
              validator: phoneValidator,
            ),
            buildTextFormField(
              controller: widget.countryController,
              labelText: 'Country',
              prefixIcon: const Icon(Iconsax.global),
              hintText: 'Nepal',
              validator: requiredFieldValidator,
            ),
            buildTextFormField(
              controller: widget.provinceController,
              labelText: 'Province',
              prefixIcon: const Icon(Iconsax.location),
              hintText: 'Province No',
              validator: requiredFieldValidator,
            ),
            buildTwoTextFormFieldRow(
              controller1: widget.districtController,
              label1: 'District',
              icon1: const Icon(Iconsax.location),
              controller2: widget.streetController,
              label2: 'Street',
              icon2: const Icon(FontAwesomeIcons.road),
              hintText1: 'eg: Rupandehi',
              hintText2: 'eg: Sainik Marga',
              validator1: requiredFieldValidator,
              validator2: requiredFieldValidator,
            ),
            buildTwoTextFormFieldRow(
              controller1: widget.wardNoController,
              label1: 'Ward',
              icon1: const Icon(Icons.map),
              controller2: widget.toleController,
              label2: 'Tole',
              icon2: const Icon(Icons.map),
              hintText1: 'Ward No',
              hintText2: 'eg: Namuna Tole',
              validator1: requiredFieldValidator,
              validator2: requiredFieldValidator,
            ),
            OutlinedButton(
              onPressed: widget.openMap,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Row(
                children: [
                  Text('Set on map'),
                  Spacer(),
                  Icon(FontAwesomeIcons.caretRight, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {
                if (widget.formKey!.currentState!.validate()) {
                  widget.onSubmit();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
