import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/common/utils/shared_preference.dart';
import 'package:vprokat/src/domain/usecase/user/delete_me_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class DeleteMeCubit extends Cubit<BaseState> {
  DeleteMeCubit(this.deleteMeUseCase) : super(const BaseState());

  final DeleteMeUseCase deleteMeUseCase;

  void deleteMe() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await deleteMeUseCase(null);

    emit(
      failureOrAuth.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }
}
