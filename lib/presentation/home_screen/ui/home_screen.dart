import 'package:flutter/material.dart';
import 'package:flutter_temp_by_nqh/config/styles.dart';
import 'package:flutter_temp_by_nqh/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Assets.images.cartoonBirdsBlueFlyingAnimationClipart.image(),
          ),
          Text(
            "Home Page",
            style: AppTextStyle.label2,
          ),
        ],
      ),
    );
  }
}
