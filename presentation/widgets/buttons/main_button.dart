import 'package:flutter/material.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';

class CustomMainButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isLoading;
  final double height;
  final Color buttonColor;
  final bool isActive;

  const CustomMainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.height = 48,
    this.buttonColor = AppColors.main,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: height,
      decoration: BoxDecoration(
          // gradient: AppColors.mainGradient,
          borderRadius: BorderRadius.circular(120),
         ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isActive ? buttonColor : AppColors.buttonGrey,
        ),
        onPressed: isActive && isLoading == false ? onTap : () {},
        child: isLoading ?? false
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.white,
              ))
            : Text(
                text,
                style: AppTextStyle.bodyLarge.copyWith(
                    color: isActive ? AppColors.white : AppColors.gray),
              ),
      ),
    );
  }
}


class CustomBlueButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isLoading;
  final double height;
  final Color buttonColor;
  final bool isActive;

  const CustomBlueButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.height = 48,
    this.buttonColor = AppColors.mainBlue,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: height,
      decoration: BoxDecoration(
        // gradient: AppColors.mainGradient,
        borderRadius: BorderRadius.circular(120),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isActive ? buttonColor : AppColors.lightBlue,
        ),
        onPressed: isActive && isLoading == false ? onTap : () {
          print('not active');
        },
        child: isLoading ?? false
            ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ))
            : Text(
          text,
          style: AppTextStyle.bodyLarge.copyWith(
              color: AppColors.white),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color buttonColor;
  final bool? isLoading;

  const CustomOutlinedButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isLoading,
      this.buttonColor = AppColors.main});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 56,
      decoration: BoxDecoration(
        // gradient: AppColors.mainGradient,
        borderRadius: BorderRadius.circular(120),
      ),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(120),
          ),
          backgroundColor: AppColors.transparent,
          side: BorderSide(width: 1.0, color: buttonColor),
          disabledForegroundColor: AppColors.gray2.withOpacity(0.38),
          disabledBackgroundColor: AppColors.gray2.withOpacity(0.12),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shadowColor: AppColors.transparent,
          elevation: 0,
          textStyle: AppTextStyle.titleSmall.copyWith(
            color: buttonColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: onTap,
        child: isLoading ?? false
            ? Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: AppColors.white)),
                child: const CircularProgressIndicator(),
              )
            : Text(
                text,
                style: AppTextStyle.titleSmall.copyWith(
                  color: buttonColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
