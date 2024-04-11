// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_attendance_system/src/services/authentication.dart';
import 'package:geo_attendance_system/src/ui/constants/colors.dart';
import 'package:geo_attendance_system/src/ui/informative_popup.dart';
import 'package:geo_attendance_system/src/ui/pages/homepage.dart';
import 'package:geo_attendance_system/src/ui/pages/login.dart';
import 'package:geo_attendance_system/src/ui/scaffold_with_background.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthenticationScreen extends StatefulWidget {
  const BiometricAuthenticationScreen(
      {Key? key, required this.user, required this.auth})
      : super(key: key);
  final User user;
  final BaseAuth? auth;

  @override
  State<BiometricAuthenticationScreen> createState() =>
      _BiometricAuthenticationScreenState();
}

class _BiometricAuthenticationScreenState
    extends State<BiometricAuthenticationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final auth = LocalAuthentication();
  String authorized = " not authorized";

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScaffoldWithBackground(
        backgroundImagePath: 'assets/logo/logo-white.png',
        backButton: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                const Spacer(),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 34),
                          Text(
                            'Welcome',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Tap to login with fingerprint.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF414141),
                            ),
                          ),
                          const SizedBox(height: 22),
                          GestureDetector(
                            onTap: _authenticate,
                            child: SvgPicture.asset(
                              'assets/logo/ic_fingerprint.svg',
                              height: 45,
                              width: 45,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Touch the fingerprint sensor",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF000000),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Login(auth: Auth())));
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF0A3161),
                                ),
                                child: const Text('Use Password'),
                              ),
                              TextButton(
                                onPressed: _faceIdAuthenticate,
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF0A3161),
                                ),
                                child: const Text('Use Face ID'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("AttendFence",
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          color: appbarcolor,
                          fontSize: 25,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold)),
                  Text("AttendFence and HR Management System",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          color: Colors.black54,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    // try {
    final isAvailable = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();
    if (!isDeviceSupported) {
      throw PlatformException(
          code: 'not_supported', message: 'Device not supported');
    } else if (!isAvailable) {
      throw PlatformException(
          code: 'not_available', message: 'Biometric not available');
    } else {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your finger to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          sensitiveTransaction: true,
          useErrorDialogs: true,
        ),
      );
    }
    // } on PlatformException catch (e) {
    //   log("ERROR____>${e.toString()}");
    //   log(e.toString());
    //   if (e.code == 'LockedOut') {
    //     showDialog(
    //       context: context,
    //       builder: (context) => const InformativePopup(
    //         title: 'Too many attempts. Please try again later.',
    //         isSuccess: false,
    //       ),
    //     );
    //   } else {
    //     showDialog(
    //       context: context,
    //       builder: (context) => const InformativePopup(
    //         title:
    //             'Device does not support biometric authentication. PLease try to login with password.',
    //         isSuccess: false,
    //       ),
    //     );
    //   }
    // }
    setState(() {
      authorized = authenticated ? 'Authorized success' : "Authorized success";
      log(authorized);
    });
    if (authenticated) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomePage(user: widget.user)));
    }
  }

  Future<void> _faceIdAuthenticate() async {
    bool authenticated = false;
    try {
      final isAvailable = await auth.canCheckBiometrics;
      final isDeviceSupported = await auth.isDeviceSupported();
      if (!isDeviceSupported) {
        throw PlatformException(
            code: 'not_supported', message: 'Device not supported');
      } else if (!isAvailable) {
        throw PlatformException(
            code: 'not_available', message: 'Face ID not available');
      } else {
        authenticated = await auth.authenticate(
          localizedReason: 'Scan Face to Authenticate',
          authMessages: [
            const AndroidAuthMessages(
              signInTitle: 'Face ID Required',
            )
          ],
          options: const AuthenticationOptions(
            stickyAuth: false,
            useErrorDialogs: false,
          ),
        );
      }
    } on PlatformException catch (e) {
      log(e.toString());
      showDialog(
        context: context,
        builder: (context) => const InformativePopup(
          title:
              'Device does not support face ID authentication. PLease try to login with password.',
          isSuccess: false,
        ),
      );
    }
    setState(() {
      authorized =
          authenticated ? 'Authorized success' : 'Failed to authenticate';
      log(authorized);
    });
    if (authenticated) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomePage(user: widget.user)));
    }
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    setState(() {});
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      log(e.toString());
    }
    setState(() {});
  }
}
