import 'package:dio/dio.dart';
import 'package:vprokat/src/data/models/orders/order_item.dart';
import 'package:vprokat/src/data/models/orders/status_count_model.dart';
import 'package:vprokat/src/domain/entity/order/order_item_entity.dart';
import 'package:vprokat/src/domain/entity/order/status_count_entity.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../../domain/usecase/order/order_item_usecase.dart';

abstract class OrderRemoteDataSource {
  Future<Map<String, dynamic>> bookItem(MapParams params);

  Future<PaginationOrderEntity> fetchOrderItems(OrderParams params);

  Future<StatusCountEntity> fetchStatusCount(PathParams params);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final API api;

  OrderRemoteDataSourceImpl(this.api);

  @override
  Future<Map<String, dynamic>> bookItem(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}orders/create/',
        data: params.data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<PaginationOrderEntity> fetchOrderItems(OrderParams params) async {
    try {
      String link = params.status.isEmpty
          ? '${constants.host}orders/?page=${params.page}'
          : '${constants.host}orders/?page=${params.page}&for_my_items=${params.isMy}&${params.status}';
      if (params.isMy) {
        link = '$link&for_my_items=${params.isMy}';
      }
      final response = await api.dio.get(link);

      if (response.statusCode == 200) {
        List<OrderItemEntity> itemEntity = (response.data['results'] as List)
            .map((e) => OrderItemModel.fromJson(e))
            .toList();
        return PaginationOrderEntity(
          isLast: response.data['next'] == null,
          itemEntity: itemEntity,
        );
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<StatusCountEntity> fetchStatusCount(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}orders/',
      );

      if (response.statusCode == 200) {
        return StatusCountModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
