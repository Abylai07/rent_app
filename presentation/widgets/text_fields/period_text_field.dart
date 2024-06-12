import 'package:flutter/material.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../common/utils/parsers/date_parser.dart';

class PeriodTextField extends StatelessWidget {
  const PeriodTextField({
    super.key,
    this.onChanged,
    this.initialValue,
  });
  final Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: S.of(context).cost,
        contentPadding: const EdgeInsets.only(
          left: 12,
          top: 8,
          bottom: 8,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.mainBlue,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.mainBlue,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [AppUtils.amountMaskFormatter],
      onChanged: onChanged,
    );
  }
}
