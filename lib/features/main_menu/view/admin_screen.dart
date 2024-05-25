import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/features/main_menu/view_model/admin_provider.dart';
import 'package:parkly/resources/assets/ImageAssets.dart';
import 'package:parkly/resources/colors/appColor.dart';
import 'package:provider/provider.dart';

import '../../../common/decorations.dart';
import '../../authentication/view_model/auth_provider.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<AdminProvider>(context, listen: false).fetchBookedParking(context.read<AuthProvider>().user!.uid);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade50,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await Provider.of<AuthProvider>(context, listen: false).logoutUser();
                  Navigator.pushReplacementNamed(context, RouteNames.signInScreen);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: IconButton(
                            color: AppColors.whiteColor,
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                              print(_scaffoldKey.currentState!.hasDrawer);
                            },
                            icon: const Icon(Icons.menu),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        const Column(
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
                          Navigator.pushNamed(context, RouteNames.addParkingDetailsScreen);
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
              const Text(
                'Cars List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 120,
              //       child: CustomButton(
              //         title: 'In Cars List',
              //         titleTextColor: AppColors.whiteColor,
              //
              //         backgroundColor: AppColors.primaryColor,
              //         onTap: () {},
              //       ),
              //     ),
              //     const SizedBox(width: 10.0),
              //     SizedBox(
              //       width: 120,
              //       child: CustomButton(
              //         title: 'Out Cars List',
              //         titleTextColor: Colors.black,
              //         backgroundColor: AppColors.whiteColor,
              //         borderColor: AppColors.primaryColor,
              //         onTap: () {},
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20.0),

              Consumer<AdminProvider>(
                builder: (context, provider, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: provider.bookedCars.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final car = provider.bookedCars[index];
                        return Card(
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
                                        child: Image.network(car['urls'][0]),
                                      ),

                                    ),
                                    const SizedBox(width: 5.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Vehicle Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                        Text(car['vehicle_name'],
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                                        const SizedBox(height: 10.0),
                                        const Text('Total Hours', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                        Text(car['total_hours'],
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('From', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                    Text(car['from_date'],
                                        style:  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                                    const SizedBox(height: 10.0),
                                    const Text('To', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                    Text(car['to_date'],
                                        style:  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                                    const SizedBox(height: 10.0),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
