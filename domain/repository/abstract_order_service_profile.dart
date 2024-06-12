import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/order/status_count_entity.dart';

import '../../core/error/failure.dart';
import '../entity/order/order_item_entity.dart';

abstract class AbstractOrderServiceRepository {

  Future<Either<Failure, Map<String, dynamic>>> bookItem(params);

  Future<Either<Failure, PaginationOrderEntity>> fetchOrderItem(params);

  Future<Either<Failure, StatusCountEntity>> fetchStatusCount(params);

 // Future<Either<Failure, AuthEntity>> signIn(params);


}