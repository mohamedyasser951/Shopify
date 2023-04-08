import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreen();
}

class _SpalashScreen extends State<SpalashScreen> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3), () {});
    if (TOKEN == null) {
      navigateAndFinish(context, LoginScreen());
    } else {
      navigateAndFinish(context, const HomeLayout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pink, Colors.white],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.shop_two_rounded,
            size: 250,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
