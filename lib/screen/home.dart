import 'package:address_form/screen/form_page/form.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            debugPrint("Add address button pressed");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddressForm(),
              ),
            );
          },
          child: const Text("Add address"),
        ),
      ),
    );
  }
}
