class Address {
  final int id;
  final String addressTitle;
  final String city;
  final String cityType;
  final String country;
  final String district;
  final String email;
  final String fullName;
  final String latitude;
  final String longitude;
  final String phoneNo;
  final String province;
  final String street;
  final String tole;
  final String wardNo;
  final DateTime createdAt;
  final DateTime updatedAt;

  Address({
    required this.id,
    required this.addressTitle,
    required this.city,
    required this.cityType,
    required this.country,
    required this.district,
    required this.email,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.phoneNo,
    required this.province,
    required this.street,
    required this.tole,
    required this.wardNo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      addressTitle: json['address_title'],
      city: json['city'],
      cityType: json['city_type'],
      country: json['country'],
      district: json['district'],
      email: json['email'],
      fullName: json['full_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phoneNo: json['phone_no'],
      province: json['province'],
      street: json['street'],
      tole: json['tole'],
      wardNo: json['ward_no'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_title': addressTitle,
      'city': city,
      'city_type': cityType,
      'country': country,
      'district': district,
      'email': email,
      'full_name': fullName,
      'latitude': latitude,
      'longitude': longitude,
      'phone_no': phoneNo,
      'province': province,
      'street': street,
      'tole': tole,
      'ward_no': wardNo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
