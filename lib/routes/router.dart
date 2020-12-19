import 'package:auto_route/auto_route_annotations.dart';
import 'package:qr_challenge/home.dart';
import 'package:qr_challenge/qr_code_screen.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routes: <AutoRoute>[
      MaterialRoute(page: QRHome, initial: true),
      MaterialRoute(page: QRCodeScreen),
    ])
class $Router {}
