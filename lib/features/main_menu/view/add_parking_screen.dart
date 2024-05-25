import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/features/authentication/view_model/auth_provider.dart';
import 'package:parkly/features/main_menu/view_model/admin_provider.dart';
import 'package:parkly/resources/colors/appColor.dart';
import 'package:provider/provider.dart';

import '../../../common/decorations.dart';
import '../../../config/routes/route_names.dart';
import '../../../resources/assets/ImageAssets.dart';

class AddParkingDetailsScreen extends StatelessWidget {
  AddParkingDetailsScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Parking Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add Parking Pictures'),
                  const SizedBox(height: 10.0),
                  Consumer<AdminProvider>(
                    builder: (context, provider, child) {
                      return provider.urls.isEmpty ?
                      const Text('Please select image from the gallery by tapping Add Button')
                      : provider.gettingImages ?
                      const SpinKitFadingCircle(color: AppColors.primaryColor,)
                      :
                      Wrap(
                        direction: Axis.horizontal,
                        children: List.generate(
                          provider.urls.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                              child: SizedBox(
                                width: 90,
                                height: 95,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.network(provider.urls[index], fit: BoxFit.fill,),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    textInputAction: TextInputAction.next,

                    decoration: TextInputDecoration.copyWith(
                      labelText: 'Location',
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Please enter valid address' : null,
                    onChanged: (value) {
                      context.read<AdminProvider>().setLocation(value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: TextInputDecoration.copyWith(
                      labelText: 'Phone Number',
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Please enter correct phone number' : null,
                    onChanged: (value) {
                      context.read<AdminProvider>().setPhonenumber(value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Consumer<AdminProvider>(
                    builder: (context, provider, child) {
                      return CustomButton(
                        title: 'Register',
                        titleTextColor: AppColors.whiteColor,
                        backgroundColor: AppColors.primaryColor,
                        isLoading: provider.isLoading,
                        onTap: () async {
                          await provider.saveData(_formKey, context.read<AuthProvider>().user?.uid);
                          if (provider.message.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.message.toString())));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          context.read<AdminProvider>().getImagesFromGallery();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add, size: 50),
            ),
          ),
        ),
      ),
    );
  }
}
