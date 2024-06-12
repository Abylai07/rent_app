import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vprokat/src/common/app_styles/app_theme.dart';
import 'package:vprokat/src/common/utils/locale/locale.dart';
import 'package:vprokat/src/presentation/bloc/button_bloc/button_bloc.dart';
import 'package:vprokat/src/presentation/bloc/obscure_bloc.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/photo_bloc/photo_bloc.dart';
import 'package:vprokat/src/presentation/view/authorization/sign_in/bloc/sign_in_cubit.dart';
import 'package:vprokat/src/presentation/view/authorization/sign_up/bloc/sign_up_cubit.dart';
import 'package:vprokat/src/presentation/view/categories/bloc/category_items_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/category_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/items_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/delete_me_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/user_info_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/user_photo_cubit.dart';

import 'common/utils/app_router/app_router.dart';
import 'common/utils/l10n/generated/l10n.dart';
import 'get_it_sl.dart';

class Application extends StatelessWidget {
  Application({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );

    return MultiBlocProvider(
      providers: [
        BlocProvider<SingInCubit>(
          create: (_) => sl<SingInCubit>(),
        ),
        BlocProvider<ItemsCubit>(
          create: (_) => sl<ItemsCubit>(),
        ),
        BlocProvider<UserInfoCubit>(
          create: (_) => sl<UserInfoCubit>(),
        ),
        BlocProvider<CityCubit>(
          create: (_) => sl<CityCubit>()..fetchCityList(),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => sl<CategoryCubit>()..fetchCategories(),
        ),
        BlocProvider<CategoryItemsCubit>(
          create: (_) => sl<CategoryItemsCubit>(),
        ),
        BlocProvider<DeleteMeCubit>(
          create: (_) => sl<DeleteMeCubit>(),
        ),
        BlocProvider<SignUpCubit>(
          create: (_) => sl<SignUpCubit>(),
        ),
        BlocProvider(
          create: (_) => ObscureBloc(),
        ),
        BlocProvider(
          create: (_) => ButtonBloc(),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => LocaleBuilder(builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: appRouter.config(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: locale,
            supportedLocales: S.delegate.supportedLocales,
            theme: AppTheme.lightTheme,
          );
          // return MaterialApp(
          //   localizationsDelegates: const [
          //     S.delegate,
          //     GlobalMaterialLocalizations.delegate,
          //     GlobalWidgetsLocalizations.delegate,
          //     GlobalCupertinoLocalizations.delegate,
          //   ],
          //   locale: locale,
          //   supportedLocales: S.delegate.supportedLocales,
          //   theme: AppTheme.lightTheme,
          //   home: const SignUpProvider(),
          // );
        }),
      ),
    );
  }
}
