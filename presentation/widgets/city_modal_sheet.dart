import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vprokat/src/common/app_styles/colors.dart';
import 'package:vprokat/src/common/app_styles/text_styles.dart';
import 'package:vprokat/src/common/enums.dart';
import 'package:vprokat/src/common/utils/shared_preference.dart';
import 'package:vprokat/src/domain/entity/user/city_entity.dart';
import 'package:vprokat/src/presentation/bloc/base_state.dart';
import 'package:vprokat/src/presentation/view/authorization/sign_up/bloc/sign_up_state.dart';
import 'package:vprokat/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:vprokat/src/presentation/widgets/buttons/main_button.dart';
import 'package:vprokat/src/presentation/widgets/containers/dot_container.dart';
import 'package:vprokat/src/presentation/widgets/show_error_snackbar.dart';

import '../../common/app_styles/assets.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import '../view/authorization/sign_up/bloc/sign_up_cubit.dart';
import '../view/home/bloc/city_bloc/city_state.dart';

cityModalBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: AppColors.white,
    constraints: BoxConstraints(
      maxHeight: 0.5.sh,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).chooseCity,
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                          child: SvgPicture.asset(AppAssets.cancel)),
                    ),
                  ],
                ),
                BlocBuilder<CityCubit, CityState>(
                  builder: (context, state) {
                    if (state.status.isSuccess) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemCount: state.entity?.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<CityCubit>()
                                    .selectCity(state.entity?[i]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.entity?[i].name ?? '',
                                        style: AppTextStyle.titleSmall,
                                      ),
                                    ),
                                    PointContainer(value: state.selectCity?.id ==  state.entity?[i].id),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (state.status.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state.status == SignUpStatus.successData) {
                      Navigator.pop(context);
                    } else if(state.status == SignUpStatus.errorData){
                      showErrorSnackBar(context, '${S.of(context).somethingWrong} ${state.message}');
                    }
                  },
                  builder: (context, state) {
                    return CustomMainButton(
                        text: S.of(context).save,
                        isActive:
                            context.watch<CityCubit>().state.selectCity != null,
                        isLoading: state.status == SignUpStatus.loading,
                        onTap: () {
                          CityEntity? city =
                              context.read<CityCubit>().state.selectCity;
                          context.read<SignUpCubit>().signUpData({
                            'city': city?.id,
                          });
                          SharedPrefs().setCityId(city?.id);
                          SharedPrefs().setCityName(city?.name);
                        });
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
