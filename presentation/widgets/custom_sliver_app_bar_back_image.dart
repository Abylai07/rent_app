import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vprokat/src/common/app_styles/assets.dart';

import '../../common/app_styles/colors.dart';
import '../../common/app_styles/text_styles.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.pinned = true,
    this.tag,
    this.onPressed,
    this.title,
    this.isShowForegroundShadow = false,
    required this.images,
    this.isHideTitle = false,
  });
  final bool pinned;
  final String? tag;
  final Function()? onPressed;
  final String? title;
  final List<String>? images;
  final bool isShowForegroundShadow;
  final bool isHideTitle;

  void navigateToImageSlider(BuildContext context, int? index) {
    if (images?.isNotEmpty == true) {
      showImageViewerPager(
          context,
          MultiImageProvider(
            initialIndex: index ?? 0,
              images!.map((e) => Image.network(e).image).toList()),
          swipeDismissible: true,
          doubleTapZoomable: true, // Регулируйте это значение
          immersive: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const min = 56.0;
    final top = MediaQuery.of(context).viewPadding.top;
    final controller = PageController(viewportFraction: 1, keepPage: true);
    return SliverAppBar(
      key: ValueKey(title),
      stretch: false,
      backgroundColor: AppColors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      pinned: pinned,
      expandedHeight: 0.4.sh,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        double minHeight = min + top;
        double padding = constraints.maxHeight - minHeight;

        bool isTransform = false;
        if (Platform.isAndroid) {
          isTransform = constraints.maxHeight > 110;
        } else {
          isTransform = constraints.maxHeight > 130;
        }
        return FlexibleSpaceBar(
          expandedTitleScale: 1,
          centerTitle: true,
          title: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            alignment: (padding - 0.128.sh + 24) < 0
                ? Alignment.bottomCenter
                : Alignment.bottomLeft,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(title ?? '',
                    maxLines: (padding - 0.128.sh + 24) < 0 ? 1 : 4,
                    textAlign: (padding - 0.128.sh + 24) < 0
                        ? TextAlign.center
                        : TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.titleSmall.copyWith(
                        color: isTransform
                            ? isHideTitle
                                ? Colors.transparent
                                : Colors.white
                            : AppColors.black)),
              ),
            ),
          ),
          background: InkWell(
            onTap: () => navigateToImageSlider(context, controller.page?.toInt()),
            child: images != null && images!.isNotEmpty
                ? Stack(children: [
                    PageView.builder(
                      controller: controller,
                      itemCount: images?.length,
                      itemBuilder: (_, index) {
                        return FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: kTransparentImage,
                          image: images![index],
                        );
                      },
                    ),
                    if (images?.isNotEmpty == true && images!.length > 1)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: images!.length,
                            effect: const WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: AppColors.mainBlue,
                                dotColor: AppColors
                                    .lightPurple), // your preferred effect
                            onDotClicked: (index) {
                              controller.jumpToPage(index);
                            },
                          ),
                        ),
                      ),
                    if (images?.isNotEmpty == true)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Image.asset(
                          AppAssets.tap,
                          color: Colors.white,
                          width: 35,
                          height: 35,
                        ),
                      )
                  ])
                : const SizedBox(),
          ),
        );
      }),
    );
  }
}
