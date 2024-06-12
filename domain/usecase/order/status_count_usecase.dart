import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/order/order_item_entity.dart';
import 'package:vprokat/src/domain/entity/order/status_count_entity.dart';
import 'package:vprokat/src/domain/repository/abstract_order_service_profile.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../item/fetch_my_items_usecase.dart';


class StatusCountUseCase extends UseCase<StatusCountEntity?, PathParams> {
  StatusCountUseCase(this.repository);

  final AbstractOrderServiceRepository repository;

  @override
  Future<Either<Failure, StatusCountEntity>> call(PathParams? params) async {
    return await repository.fetchStatusCount(params);
  }
}


