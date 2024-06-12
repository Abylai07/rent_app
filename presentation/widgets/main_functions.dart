import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_styles/colors.dart';
import '../../common/utils/l10n/generated/l10n.dart';

void launchUrlFunc(String link, {bool browser = false}) async {
  Uri uri = Uri.parse(link);
  await launchUrl(uri,
      mode: browser
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault);
}


String removeNonNumeric(String input) {
  // Use a regular expression to replace all non-numeric characters with an empty string
  return input.replaceAll(RegExp(r'[^0-9]'), '');
}

String? getNameByStatus(BuildContext ctx, String key){
  final data = {
    'all' : S.of(ctx).all,
    'new' : S.of(ctx).newStatus,
    'accepted' : S.of(ctx).acceptedStatus,
    'in_progress' : S.of(ctx).inProgressStatus,
    'closed' : S.of(ctx).closedStatus,
  };
  return data[key];
}

Color? getColorByStatus(String key){
  final data = {
    'all' : AppColors.black,
    'new' :  AppColors.green,
    'accepted' :  AppColors.black,
    'in_progress' :  AppColors.mainBlue,
    'closed' : AppColors.errorRedColor,
  };
  return data[key];
}