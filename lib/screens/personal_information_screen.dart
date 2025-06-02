import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plovo/providers/user_provider.dart';
import 'package:plovo/widgets/address_form/address_form.dart';
import 'package:plovo/widgets/address_form/address_form_controller.dart';

class PersonalInformationScreen extends ConsumerStatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  ConsumerState<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends ConsumerState<PersonalInformationScreen> {
  final addressFormController = AddressFormController();

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    if (user != null) {
      addressFormController.setUser(user);
    }
  }

  void saveProfile() {
    if (addressFormController.formKey.currentState!.validate()) {
      final user = addressFormController.getUser();
      ref.read(userProvider.notifier).state = user;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Personal information updated!')));
      Navigator.of(context).pop();
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
