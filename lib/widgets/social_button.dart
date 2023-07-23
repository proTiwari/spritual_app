import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/appconstants.dart';


class SocialButtonWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final double horizontalPadding;

  const SocialButtonWidget({
    Key? key,
    required this.imagePath,
    required this.label,
    this.horizontalPadding = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: SvgPicture.asset(
        imagePath,
        width: 25,
        color: AppColors.whiteColor,
      ),
      onPressed: () {},
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 17,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.borderColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
