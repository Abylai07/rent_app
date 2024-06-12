import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/common/enums.dart';
import 'package:vprokat/src/domain/usecase/user/logout_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../../../common/utils/shared_preference.dart';
import '../../../../bloc/base_state.dart';

class SingInCubit extends Cubit<BaseState> {
  SingInCubit(this.signInUseCase, this.logOutUseCase) : super(const BaseState());

  final SignInUseCase signInUseCase;
  final LogOutUseCase logOutUseCase;

  void signIn(Map<String, dynamic> data) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await signInUseCase(MapParams(data));

    if (failureOrAuth.isRight()) {
      final data = failureOrAuth.toOption().toNullable();
      SharedPrefs().setAccessToken(data?.token);
      SharedPrefs().setRefreshToken(data?.refreshToken);
    }

    emit(
      failureOrAuth.fold(
            (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => BaseState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  void logout() async {
    emit(const BaseState(status: CubitStatus.loading));


    final failureOrAuth = await logOutUseCase(null);

    emit(
      failureOrAuth.fold(
            (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => BaseState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }
}
