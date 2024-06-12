import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/order/order_item_entity.dart';
import 'package:vprokat/src/domain/entity/order/status_count_entity.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';
import '../../domain/repository/abstract_order_service_profile.dart';
import '../datasources/order_remote_data_source.dart';

class OrderServiceRepositoryImpl extends AbstractOrderServiceRepository {
  OrderServiceRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final OrderRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, Map<String, dynamic>>> bookItem(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.bookItem(params));
  }

  @override
  Future<Either<Failure, PaginationOrderEntity>> fetchOrderItem(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchOrderItems(params));
  }

  @override
  Future<Either<Failure, StatusCountEntity>> fetchStatusCount(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchStatusCount(params));
  }
}
