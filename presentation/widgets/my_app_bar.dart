import 'package:flutter/material.dart';

import '../../common/app_styles/text_styles.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import 'text_fields/custom_text_field.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key,
      required this.title,
      this.onChanged,
      this.centerTitle = false,
      this.controller});
  final String title;
  final bool centerTitle;
  final TextEditingController? controller;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title,
        style: AppTextStyle.appBarStyle,
      ),
      bottom: onChanged != null
          ? PreferredSize(
              preferredSize:
                  Size(MediaQuery.of(context).size.width, kToolbarHeight),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                  child: SearchTextFieldWidget(
                    isNotFilled: false,
                    controller: controller,
                    hintText: S.of(context).search,
                    onChanged: onChanged,
                  )))
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(onChanged == null ? 56 : 106);
}
