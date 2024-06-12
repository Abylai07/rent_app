import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vprokat/src/common/enums.dart';

import '../../common/app_styles/assets.dart';
import '../../common/app_styles/colors.dart';
import '../../common/app_styles/text_styles.dart';
import '../../common/utils/l10n/generated/l10n.dart';

class AddPhotoModal extends StatelessWidget {
  const AddPhotoModal({super.key, this.onGalleryTap, this.onCameraTap});
  final Function()? onGalleryTap;
  final Function()? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          color: AppColors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addPhoto,
                    style: AppTextStyle.titleLarge,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.mainBlue,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 21),
                child: InkWell(
                  onTap: onCameraTap,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.camera),
                      12.width,
                      Text(
                        S.of(context).takePhoto,
                        style: AppTextStyle.labelLarge
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: onGalleryTap,
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.gallery),
                    12.width,
                    Text(
                      S.of(context).selectPhoto,
                      style: AppTextStyle.labelLarge
                          .copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
}

