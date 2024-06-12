import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/common/enums.dart';
import 'package:vprokat/src/domain/usecase/item/fetch_item_detail_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../bloc/base_state.dart';


class ItemDetailCubit extends Cubit<BaseState> {
  ItemDetailCubit(this.fetchItemDetailUseCase) : super(const BaseState());

  final FetchItemDetailUseCase fetchItemDetailUseCase;

  void fetchCategories(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await fetchItemDetailUseCase(PathParams(id.toString()));

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
