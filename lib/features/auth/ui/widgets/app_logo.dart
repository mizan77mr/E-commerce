import 'package:crafty_bay/app/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPath.appLogo,
      height: height,
      width: width ?? 120,
      fit: BoxFit.scaleDown,
    );
  }
}
