import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/order/order_item_entity.dart';
import 'package:vprokat/src/domain/repository/abstract_order_service_profile.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../item/fetch_my_items_usecase.dart';


class OrderItemUseCase extends UseCase<PaginationOrderEntity?, OrderParams> {
  OrderItemUseCase(this.repository);

  final AbstractOrderServiceRepository repository;

  @override
  Future<Either<Failure, PaginationOrderEntity>> call(OrderParams? params) async {
    return await repository.fetchOrderItem(params);
  }
}

class OrderParams {
  const OrderParams({required this.page, this.status = '', this.isMy = false});

  final int page;
  final String status;
  final bool isMy;

}

