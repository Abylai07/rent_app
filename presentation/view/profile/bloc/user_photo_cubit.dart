import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/common/utils/shared_preference.dart';
import 'package:vprokat/src/domain/usecase/item/item_photo_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/delete_me_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/user_photo_usecase.dart';
import 'package:vprokat/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class UserPhotoCubit extends Cubit<BaseState> {
  UserPhotoCubit(this.userPhotoUseCase) : super(const BaseState());

  final UserPhotoUseCase userPhotoUseCase;

  void updateUserPhoto(FormData data) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await userPhotoUseCase.updateUserImage(FormParams(data));

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

  void removeUserPhoto() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await userPhotoUseCase.removeUserImage();

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
