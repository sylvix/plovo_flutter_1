class User {
  final String firstName;
  final String lastName;
  final String address;

  const User({
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  User copyWith({String? firstName, String? lastName, String? address}) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {'firstName': firstName, 'lastName': lastName, 'address': address};
  }
}
