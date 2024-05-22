import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkly/config/routes/route_names.dart';
import 'package:parkly/features/authentication/view/selection_screen.dart';
import 'package:parkly/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_divider.dart';
import '../../../common/decorations.dart';
import '../../../resources/assets/ImageAssets.dart';
import '../../../resources/colors/appColor.dart';
import '../view_model/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text(
          'Forget Password',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Reset your password', style: TextStyle(fontSize: 30)),
                  const Text('Please enter your email to receive a One-Time Password (OTP) for verification.'),
                  const SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.black,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: TextInputDecoration,
                          validator: (value) => value!.isEmpty ? 'Please enter email address' : null,
                          onChanged: (value) {
                            context.read<AuthProvider>().setEmail(value);
                          },
                        ),
                        const SizedBox(height: 15.0),
                        Consumer<AuthProvider>(
                          builder: (context, provider, child) {
                            return CustomButton(
                              title: 'Next',
                              titleTextColor: AppColors.whiteColor,
                              backgroundColor: AppColors.primaryColor,
                              isLoading: provider.isLoading,
                              onTap: () async {
                                await provider.verifyEmail(_formKey,provider.email);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(provider.message)),
                                );
                                // Utils.showMessageDialog(context, 'message', Icons.add, Colors.black);

                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       backgroundColor: AppColors.whiteColor,
                                //       shape: const BeveledRectangleBorder(),
                                //       content: SizedBox(
                                //         height: screenHeight * 0.5,
                                //         width: screenWidth,
                                //         child: SingleChildScrollView(
                                //           child: Column(
                                //             children: [
                                //               const Text('Enter your 6 digit code'),
                                //               SizedBox(height: screenHeight * 0.05),
                                //               SvgPicture.asset(ImageAssets.emailIcon),
                                //               Consumer<AuthProvider>(
                                //                 builder: (context, authProvider, _) => Row(
                                //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //                   children: List.generate(
                                //                     6,
                                //                     (index) => SizedBox(
                                //                       width: 35.0,
                                //                       child: TextFormField(
                                //                         onChanged: (value) {
                                //                           if (value.length > 1) {
                                //                             value = value.substring(0, 1);
                                //                             authProvider.updateOTPDigit(index, value);
                                //                           } else if (value.isEmpty) {
                                //                             authProvider.updateOTPDigit(index, '');
                                //                           } else {
                                //                             authProvider.updateOTPDigit(index, value);
                                //                             if (index < 5) {
                                //                               FocusScope.of(context).nextFocus();
                                //                             } else {
                                //                               FocusScope.of(context).unfocus();
                                //                             }
                                //                           }
                                //                         },
                                //                         decoration: const InputDecoration(
                                //                           border: OutlineInputBorder(
                                //                             borderRadius: BorderRadius.zero
                                //                           ),
                                //                           focusedBorder: OutlineInputBorder(
                                //                               borderRadius: BorderRadius.zero
                                //                           ),
                                //                           enabledBorder: OutlineInputBorder(
                                //                               borderRadius: BorderRadius.zero
                                //                           ),
                                //                           counterText: '',
                                //                         ),
                                //                         keyboardType: TextInputType.number,
                                //                         textAlign: TextAlign.center,
                                //                         maxLength: 1,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //               SizedBox(height: screenHeight * 0.09),
                                //               Consumer<AuthProvider>(
                                //                 builder: (context, provider, child) {
                                //                   return CustomButton(
                                //                     title: 'Verify',
                                //                     titleTextColor: AppColors.whiteColor,
                                //                     backgroundColor: AppColors.primaryColor,
                                //                     isLoading: provider.isLoading,
                                //                     onTap: () {
                                //                       Navigator.of(context).pop();
                                //                     },
                                //                   );
                                //                 },
                                //               ),
                                //
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );

                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       surfaceTintColor: AppColors.whiteColor,
                                //       shape: const BeveledRectangleBorder(),
                                //       content: SizedBox(
                                //         height: screenHeight * 0.5,
                                //         width: screenWidth,
                                //         child: SingleChildScrollView(
                                //           child: Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 16.0),
                                //             child: Column(
                                //               children: [
                                //                 const Text('Enter your 6 digit code'),
                                //                 SizedBox(height: screenHeight * 0.09),
                                //                 SvgPicture.asset(ImageAssets.verifiedIcon),
                                //                 SizedBox(height: screenHeight * 0.09),
                                //                 const Text(
                                //                   'Verified!',
                                //                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                                //                 ),
                                //                 const SizedBox(height: 10.0),
                                //                 const Text(
                                //                   'Hurrah!!  You have successfully verified the account.',
                                //                   style: TextStyle(
                                //                     fontWeight: FontWeight.w400,
                                //                     fontSize: 14,
                                //                     color: AppColors.lightGreyColor,
                                //                   ),
                                //                   textAlign: TextAlign.center,
                                //                 ),
                                //                 const SizedBox(height: 10.0),
                                //                 Consumer<AuthProvider>(
                                //                   builder: (context, provider, child) {
                                //                     return CustomButton(
                                //                       title: 'Done',
                                //                       titleTextColor: AppColors.whiteColor,
                                //                       backgroundColor: AppColors.primaryColor,
                                //                       isLoading: provider.isLoading,
                                //                       onTap: () {
                                //                         Navigator.pushNamed(context, RouteNames.signInScreen);
                                //                       },
                                //                     );
                                //                   },
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.2),
                    child: const CustomDivider(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
