import 'package:address_form/models/address.dart';
import 'package:flutter/material.dart';

void printAddress(Address address) {
  debugPrint('Address Title: ${address.addressTitle}');
  debugPrint('City: ${address.city}');
  debugPrint('City Type: ${address.cityType}');
  debugPrint('Country: ${address.country}');
  debugPrint('District: ${address.district}');
  debugPrint('Email: ${address.email}');
  debugPrint('Full Name: ${address.fullName}');
  debugPrint('Latitude: ${address.latitude}');
  debugPrint('Longitude: ${address.longitude}');
  debugPrint('Phone No: ${address.phoneNo}');
  debugPrint('Province: ${address.province}');
  debugPrint('Street: ${address.street}');
  debugPrint('Tole: ${address.tole}');
  debugPrint('Ward No: ${address.wardNo}');
  debugPrint('Created At: ${address.createdAt}');
  debugPrint('Updated At: ${address.updatedAt}');
}
