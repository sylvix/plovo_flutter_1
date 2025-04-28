import 'package:flutter/cupertino.dart';
import 'package:plovo/models/user.dart';

class AddressFormController {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  User getUser() {
    return User(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      address: addressController.text,
    );
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
  }
}
