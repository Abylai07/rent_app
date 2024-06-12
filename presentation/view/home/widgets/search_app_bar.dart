import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vprokat/src/common/enums.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar(
      {super.key,
      required this.title,
      this.onChanged,
      this.centerTitle = false});
  final String title;
  final bool centerTitle;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Row(
        children: [
          SvgPicture.asset(
            AppAssets.city,
            height: 18,
          ),
          6.width,
          Text(
            title,
            style: AppTextStyle.titleSmall,
          ),
        ],
      ),
      bottom: onChanged != null
          ? PreferredSize(
              preferredSize:
                  Size(MediaQuery.of(context).size.width, kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                child: SearchTextFieldWidget(
                  isNotFilled: false,
                  hintText: S.of(context).search,
                  onChanged: onChanged,
                ),
              ))
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(onChanged == null ? 56 : 102);
}
