import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/features/book_parking/view_model/main_menu_provider.dart';
import 'package:parkly/features/main_menu/model/parking_model.dart';
import 'package:parkly/resources/assets/ImageAssets.dart';
import 'package:parkly/resources/colors/appColor.dart';
import 'package:provider/provider.dart';

class ParkingDetailsScreen extends StatefulWidget {
  const ParkingDetailsScreen({super.key});

  @override
  State<ParkingDetailsScreen> createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var parking = Provider.of<MainMenuProvider>(context).parking;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CarouselSlider(
                  carouselController: context.read<MainMenuProvider>().carouselController,
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      context.read<MainMenuProvider>().setCarouselCurrentIndex(index);
                    },
                  ),
                  items: parking.urls.map((url) {
                    return Builder(
                      builder: (context) {
                        return Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: parking.urls.asMap().entries.map((e) {
                    return Container(
                      width: 16.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: context.read<MainMenuProvider>().carouselCurrentIndex == e.key
                            ? AppColors.primaryColor
                            : Colors.black.withOpacity(0.2),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.locationIcon),
                      const SizedBox(width: 15.0),
                      Text(
                        parking.location,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        parking.phoneNumber,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                title: 'Enter Park',
                titleTextColor: AppColors.whiteColor,
                backgroundColor: AppColors.primaryColor,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.bookParkingScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
