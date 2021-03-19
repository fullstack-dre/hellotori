import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hellotori/configs/configs.dart';
import 'package:hellotori/model/model.dart';
import 'package:hellotori/providers/providers.dart';
import 'package:hellotori/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

part "authentication/auth_widget.dart";
part "authentication/auth_page.dart";
part "authentication/onboarding_pages.dart";
part "homepage/event_page.dart";
part "homepage/detailed_event_page.dart";
part "homepage/live_event_page.dart";
part "template/splash_content.dart";
part "template/header_page.dart";