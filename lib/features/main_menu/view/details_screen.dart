import 'package:flutter/material.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/resources/colors/appColor.dart';

import '../../../common/decorations.dart';
import '../../../resources/assets/ImageAssets.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
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
                  Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                      5,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                          child: SizedBox(
                            width: 90,
                            height: 95,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              child: Image.asset(
                                ImageAssets.demoImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                    onChanged: (value) {},
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
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    title: 'Save',
                    titleTextColor: AppColors.whiteColor,
                    backgroundColor: AppColors.primaryColor,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          print('image selected');
        },
        child: Container(
          decoration: const BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: const Icon(Icons.add, size: 50),
        ),
      ),
    );
  }
}
