import 'package:flutter/material.dart';
import 'package:plovo/widgets/address_form/address_form_controller.dart';

class AddressForm extends StatefulWidget {
  final AddressFormController controller;

  const AddressForm({super.key, required this.controller});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Column(
          children: [
            TextFormField(
              controller: widget.controller.firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name!';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: widget.controller.lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name!';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: widget.controller.addressController,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address!';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
