import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkly/features/book_parking/view_model/main_menu_provider.dart';
import 'package:parkly/resources/assets/ImageAssets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../common/decorations.dart';
import '../../../config/routes/route_names.dart';
import '../../../resources/colors/appColor.dart';
import '../../authentication/view/selection_screen.dart';
import '../../authentication/view_model/auth_provider.dart';

class MainMenuScreen extends StatefulWidget {
  MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  GoogleMapController? googleMapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Permission.location.request();
    if (await Permission.location.isGranted) {
      await Provider.of<MainMenuProvider>(context, listen: false).getCurrentLocation();
      await Provider.of<MainMenuProvider>(context, listen: false).fetchParkings();
      Provider.of<MainMenuProvider>(context, listen: false).setMarkers(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  await context.read<AuthProvider>().logoutUser();
                  Navigator.pushReplacementNamed(context, RouteNames.signInScreen);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: IconButton(
                        color: AppColors.whiteColor,
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome to the Parkly',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                          return Text(
                            provider.userName ?? 'hello',
                            style: const TextStyle(fontSize: 18.0),
                          );
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<MainMenuProvider>(
              builder: (context, provider, child) {
                return provider.currentPosition == null
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: false,
                          onMapCreated: (controller) {
                            provider.onMapCreated;
                            provider.setMarkers(context);
                            provider.googleMapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(target: provider.currentPosition!, zoom: 14),
                              ),
                            );
                          },
                          initialCameraPosition: CameraPosition(
                            target: provider.currentPosition!, // initial camera position
                            zoom: 14.0,
                          ),
                          markers: provider.markers,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
