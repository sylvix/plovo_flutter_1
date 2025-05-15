import 'package:flutter/material.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/widgets/address_form/address_form.dart';
import 'package:plovo/widgets/address_form/address_form_controller.dart';
import 'package:provider/provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final addressFormController = AddressFormController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = context.watch<UserProvider>().user;
    if (user != null) {
      addressFormController.setUser(user);
    }
  }

  void saveProfile() {
    if (addressFormController.formKey.currentState!.validate()) {
      final user = addressFormController.getUser();
      context.read<UserProvider>().setUser(user);
    }
  }

  @override
  void dispose() {
    addressFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(title: Text('Personal Information')),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomPadding + 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal Information', style: theme.textTheme.titleLarge),
              SizedBox(height: 16),
              AddressForm(controller: addressFormController),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
