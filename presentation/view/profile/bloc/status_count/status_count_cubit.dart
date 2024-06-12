import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/domain/entity/items/categories_entity.dart';
import 'package:vprokat/src/domain/usecase/order/status_count_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../../../common/enums.dart';
import 'status_count_state.dart';

class StatusCountCubit extends Cubit<StatusCountState> {
  StatusCountCubit(this.statusCountUseCase)
      : super(const StatusCountState());

  final StatusCountUseCase statusCountUseCase;

  void fetchStatusCount(bool isMy) async {
    emit(const StatusCountState(status: CubitStatus.loading));

    final failureOrAuth = await statusCountUseCase(PathParams(isMy ? 'isMy' : ''));

    emit(
      failureOrAuth.fold(
          (l) => StatusCountState(
                status: CubitStatus.error,
                message: l.message,
              ), (r) {
            int count = r.closedCount + r.inProgressCount + r.acceptedCount + r.newCount;
        return StatusCountState(
          status: CubitStatus.success,
          entity: r,
          count: count,
        );
      }),
    );
  }

  selectStatus(String status) async {
    emit(state.copyWith(selectStatus: status));
  }
}
