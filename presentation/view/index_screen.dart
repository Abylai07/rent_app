import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vprokat/src/common/app_styles/assets.dart';
import 'package:vprokat/src/common/enums.dart';
import 'package:vprokat/src/common/utils/app_router/app_router.dart';
import 'package:vprokat/src/common/utils/shared_preference.dart';
import 'package:vprokat/src/domain/entity/user/user_entity.dart';
import 'package:vprokat/src/presentation/view/authorization/sign_in/sign_in_screen.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/user_info_cubit.dart';
import 'package:vprokat/src/presentation/widgets/city_modal_sheet.dart';

import '../bloc/base_state.dart';

@RoutePage()
class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = SharedPrefs().getAccessToken();
    bool showModal = true;

    if (token != null) {
      context.read<UserInfoCubit>().fetchUserInfo();
    }

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        CategoriesRoute(),
        AddItemRoute(),
        ProfileRoute()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return BlocListener<UserInfoCubit, BaseState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              UserEntity user = state.entity;
              if (user.city == null && showModal) {
                showModal = false;
                cityModalBottomSheet(context);
              } else {
                SharedPrefs().setCityId(user.city);
              }
            }
          },
          child: Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              onTap: (value) async {
                token = SharedPrefs().getAccessToken();
                if ((value == 3 || value == 2) && token == null) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    constraints: BoxConstraints(
                      maxHeight: 0.9.sh,
                    ),
                    builder: (context) {
                      return const SignInScreen();
                    },
                  );
                } else {
                  if (value == 2 &&
                      token != null &&
                      (SharedPrefs().getVerifyOrganization() ?? true)) {
                    context.read<UserInfoCubit>().fetchUserInfo();
                  }
                  tabsRouter.setActiveIndex(value);
                }
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 26,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppAssets.icon1),
                    activeIcon: SvgPicture.asset(AppAssets.iconActive1),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppAssets.icon2),
                    activeIcon: SvgPicture.asset(AppAssets.iconActive2),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppAssets.icon3),
                    activeIcon: SvgPicture.asset(AppAssets.iconActive3),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppAssets.icon4),
                    activeIcon: SvgPicture.asset(AppAssets.iconActive4),
                    label: ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
