import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vprokat/src/common/app_styles/text_styles.dart';
import 'package:vprokat/src/common/enums.dart';
import 'package:vprokat/src/domain/entity/user/user_entity.dart';
import 'package:vprokat/src/presentation/bloc/base_state.dart';
import 'package:vprokat/src/presentation/view/add_item/screens/sign_up_organization.dart';
import 'package:vprokat/src/presentation/view/add_item/widget/category_select_widget.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/user_info_cubit.dart';
import 'package:vprokat/src/presentation/widgets/text_fields/custom_text_field.dart';

import '../../../common/utils/app_router/app_router.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../common/utils/shared_preference.dart';
import '../../../domain/entity/items/categories_entity.dart';
import '../../widgets/my_app_bar.dart';
import '../home/bloc/category_cubit.dart';

@RoutePage()
class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: MyAppBar(
          centerTitle: true,
          title: S.of(context).addItem,
        ),
        body: BlocConsumer<UserInfoCubit, BaseState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              UserEntity user = state.entity;
              if (user.organizationType == '' || user.organizationType == null) {
                SharedPrefs().setVerifyOrganization(true);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  constraints: BoxConstraints(
                    maxHeight: 0.9.sh,
                  ),
                  builder: (context) {
                    return const SignUpOrganization();
                  },
                );
              } else {
                SharedPrefs().setVerifyOrganization(false);
              }
            }
          },
          builder: (context, state) {
            if (state.status.isSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).itemName,
                      style: AppTextStyle.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFieldWidget(
                                hintText: S.of(context).itemNameHint,
                                controller: controller,
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).mustFill;
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      S.of(context).selectCategory,
                      style: AppTextStyle.titleSmall,
                    ),
                    // SearchTextFieldWidget(
                    //   controller: controller,
                    //   hintText: S.of(context).search,
                    //   onChanged: onChanged,
                    // )
                    12.height,
                    BlocBuilder<CategoryCubit, BaseState>(
                      builder: (context, state) {
                        if (state.status.isSuccess) {
                          List<CategoryEntity> categories = state.entity;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, i) {
                              return CategorySelectWidget(
                                category: categories[i],
                                onTap: () {
                                  if (controller.text.isEmpty) {
                                    formKey.currentState?.validate();
                                  } else {
                                    context.router.push(SelectSubCategoryRoute(
                                        titleItem: controller.text,
                                        category: categories[i]));
                                  }
                                },
                              );
                            },
                          );
                        } else if (state.status.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              );
            } else if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
