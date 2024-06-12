import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/presentation/view/home/item_card/widgets/select_add_address_widget.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/items/item_detail_entity.dart';
import '../../../../widgets/containers/border_container.dart';
import '../../../../widgets/expandable_theme.dart';
import '../bloc/obtainment_bloc.dart';

class ObtainmentPartView extends StatelessWidget {
  const ObtainmentPartView({
    super.key,
    required this.obtainmentTypes,
  });

  final List<ObtainmentTypeEntity> obtainmentTypes;

  @override
  Widget build(BuildContext context) {
    ExpandableController expandableController = ExpandableController();
    ExpandableController addressController = ExpandableController();

    return BlocBuilder<ObtainmentTypeBloc, ObtainmentTypeState>(
      builder: (context, state) {
        if (state is ObtainmentTypeChanged) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderContainer(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppColors.mainBlue,
                child: ExpandablePanel(
                  controller: expandableController,
                  theme: buildExpandableThemeData(),
                  header: Text(
                    state.obtainmentType.name,
                    style: AppTextStyle.bodyLarge,
                  ),
                  collapsed: const SizedBox(),
                  expanded: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: obtainmentTypes.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<ObtainmentTypeBloc>()
                                .add(ChangeObtainmentType(obtainmentTypes[i]));
                            expandableController.toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              obtainmentTypes[i].name,
                              style: AppTextStyle.labelLarge.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              if (state.obtainmentType.id == 2) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    S.of(context).address,
                    style: AppTextStyle.titleSmall,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SelectAddAddress(),
              ]
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
