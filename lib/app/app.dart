library app_layer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_temp_by_nqh/app/managers/shared_pref_manager.dart';
import 'package:flutter_temp_by_nqh/app/utils/navigation_util.dart';
import 'package:flutter_temp_by_nqh/firebase/firebase_options.dart' as prod;
import 'package:flutter_temp_by_nqh/firebase/firebase_options_dev.dart' as dev;
import 'package:flutter_temp_by_nqh/firebase/firebase_options_staging.dart'
    as staging;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:alice/alice.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'managers/config_manager.dart';
part 'managers/colors_manager.dart';
part 'managers/styles_manager.dart';
part 'managers/theme_manager.dart';
part 'di/injection.dart';
