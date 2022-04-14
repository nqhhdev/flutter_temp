import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_temp_by_nqh/config/styles.dart';
import 'package:flutter_temp_by_nqh/gen/assets.gen.dart';
import 'package:flutter_temp_by_nqh/utils/route/app_routing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  String get _initRoute {
    return RouteDefine.homeScreen.name;
  }

  void changeScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, _initRoute);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    changeScreen();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              child: Assets.images.animatedCatImage0301.image(),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 1.sw - 100,
            height: 2.w,
            child: LinearProgressIndicator(
              backgroundColor: Colors.blue[200],
              value: controller.value,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Welcome",
            style: AppTextStyle.label4,
          ),
        ],
      ),
    );
  }
}