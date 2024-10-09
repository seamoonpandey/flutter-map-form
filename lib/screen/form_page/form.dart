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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add new address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextFormField(
              controller: widget.addressTitleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.list_alt_outlined,
                ),
                hintText: 'Home, Office, etc.',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                label: Text('Address Title'),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextFormField(
              controller: widget.fullNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Iconsax.user,
                ),
                label: Text('Name'),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextFormField(
              controller: widget.emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  FontAwesomeIcons.envelope,
                ),
                hintText: 'yourmail@example.com',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                label: Text('Email'),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextFormField(
              controller: widget.phoneNoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Iconsax.mobile,
                ),
                hintText: '98********',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                label: Text('Phone Number'),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.countryController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Iconsax.global,
                      ),
                      hintText: 'Nepal',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      label: Text('Country'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    controller: widget.provinceController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Iconsax.location,
                      ),
                      hintText: 'eg: Lumbini Province',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      label: Text('Province'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.districtController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Iconsax.location,
                      ),
                      hintText: 'Rupandehi',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      label: Text('District'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    controller: widget.streetController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        FontAwesomeIcons.road,
                      ),
                      hintText: 'eg: sainik marga',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      label: Text('Street'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.wardNoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      label: Text('Ward'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    controller: widget.toleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.map,
                      ),
                      hintText: 'eg: namuna tole',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      label: Text('Tole'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),

            // Button to open map
            OutlinedButton(
              onPressed: widget.openMap,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Full width
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Sharp corners
                ),
              ),
              child: const Row(
                children: [
                  Text('Set on map'),
                  Spacer(),
                  Icon(
                    FontAwesomeIcons.caretRight,
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ElevatedButton(
              onPressed: widget.onSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Full width
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Sharp corners
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
