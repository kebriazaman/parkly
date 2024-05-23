import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/resources/assets/ImageAssets.dart';
import 'package:parkly/resources/colors/appColor.dart';

import '../../../common/decorations.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            child: Icon(Icons.person),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(fontSize: 14.0),
                              ),
                              Text(
                                'Kebria',
                                style: TextStyle(fontSize: 14.0),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: CustomButton(
                          title: 'Add Details',
                          titleTextColor: AppColors.whiteColor,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.detailsScreen);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: TextInputDecoration.copyWith(
                    labelText: 'Find your car',
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    border: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.whiteColor)),
                    focusedBorder:
                        const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.whiteColor)),
                    enabledBorder:
                        const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.whiteColor)),
                    suffixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: CustomButton(
                        title: 'In Cars List',
                        titleTextColor: AppColors.whiteColor,

                        backgroundColor: AppColors.primaryColor,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      width: 120,
                      child: CustomButton(
                        title: 'Out Cars List',
                        titleTextColor: Colors.black,
                        backgroundColor: AppColors.whiteColor,
                        borderColor: AppColors.primaryColor,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Card(
                  surfaceTintColor: AppColors.whiteColor,
                  color: AppColors.whiteColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 95,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                child: Image.asset(ImageAssets.demoImage),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vehicle Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                Text('TZ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                                SizedBox(height: 10.0),
                                Text('Total Hours', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                Text('4 hours', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Out Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            const Text('12 to 12 pm',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Container(
                                width: 50,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: CustomButton(
                                  title: 'View',
                                  titleTextColor: AppColors.whiteColor,
                                  backgroundColor: AppColors.primaryColor,
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
