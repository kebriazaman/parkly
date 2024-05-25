import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/features/book_parking/view_model/main_menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/decorations.dart';
import '../../../resources/colors/appColor.dart';
import '../../main_menu/view_model/admin_provider.dart';

class BookParking extends StatelessWidget {
  BookParking({super.key});
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
          'Enter your Details',
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
                  const SizedBox(height: 10.0),
                  Consumer<MainMenuProvider>(
                    builder: (context, provider, child) {
                      return provider.urls.isEmpty
                          ? const Text('Add your Vehicle Images', style: TextStyle(decoration: TextDecoration.underline))
                          : provider.gettingImages
                              ? const SpinKitFadingCircle(
                                  color: AppColors.primaryColor,
                                )
                              : Wrap(
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
                                            child: Image.network(
                                              provider.urls[index],
                                              fit: BoxFit.fill,
                                            ),
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
                      labelText: 'Vehicle Name',
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Please enter valid vehicle name' : null,
                    onChanged: (value) {
                      context.read<MainMenuProvider>().setVehicleName(value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Select Time', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<MainMenuProvider>(
                          builder: (context, provider, child) {
                            return TextFormField(
                              controller: TextEditingController(
                                  text: provider.fromDate == null
                                      ? ''
                                      : '${provider.fromDate?.day}/${provider.fromDate?.month}/${provider.fromDate?.year}'),
                              readOnly: true,
                              cursorColor: Colors.black,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              decoration: TextInputDecoration.copyWith(
                                labelText: 'From',
                                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Invalid from date' : null,
                              onTap: () async {
                                final datePicked =
                                    await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2050));
                                if (datePicked != null) {
                                  provider.setDatePickerFromDate(datePicked);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Consumer<MainMenuProvider>(
                          builder: (context, provider, child) {
                            return TextFormField(
                              controller: TextEditingController(
                                  text: provider.toDate == null
                                      ? ''
                                      : '${provider.toDate?.day}/${provider.toDate?.month}/${provider.toDate?.year}'),
                              readOnly: true,
                              cursorColor: Colors.black,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              decoration: TextInputDecoration.copyWith(
                                labelText: 'From',
                                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Invalid from date' : null,
                              onTap: () async {
                                final datePicked =
                                    await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2050));
                                if (datePicked != null) {
                                  provider.setDatePickerToDate(datePicked);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: TextInputDecoration.copyWith(
                      labelText: 'Total Hours',
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Please enter valid hours' : null,
                    onChanged: (value) {
                      context.read<MainMenuProvider>().setTotalHours(value);
                    },
                  ),
                  const SizedBox(height: 25.0),
                  Consumer<MainMenuProvider>(
                    builder: (context, provider, child) {
                      return CustomButton(
                        title: 'Book Parking',
                        titleTextColor: AppColors.whiteColor,
                        isLoading: provider.isLoading,
                        backgroundColor: AppColors.primaryColor,
                        onTap: () async {
                          await provider.bookParking(_formKey);
                          if (provider.isDone) {
                            Navigator.pushNamed(context, RouteNames.mainMenuScreen);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.message)));
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
          context.read<MainMenuProvider>().getImagesFromGallery();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
