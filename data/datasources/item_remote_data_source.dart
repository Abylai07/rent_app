import 'package:dio/dio.dart';
import 'package:vprokat/src/data/models/items/categories_model.dart';
import 'package:vprokat/src/data/models/items/id_name_model.dart';
import 'package:vprokat/src/data/models/items/my_item_model.dart';
import 'package:vprokat/src/domain/entity/items/categories_entity.dart';
import 'package:vprokat/src/domain/entity/items/id_name_entity.dart';
import 'package:vprokat/src/domain/entity/items/item_detail_entity.dart';
import 'package:vprokat/src/domain/entity/items/item_entity.dart';
import 'package:vprokat/src/domain/entity/items/item_for%20_update.dart';
import 'package:vprokat/src/domain/entity/items/my_items_entity.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../../domain/entity/items/create_item_entity.dart';
import '../../domain/usecase/item/change_item_usecase.dart';
import '../../domain/usecase/item/fetch_items_usecase.dart';
import '../../domain/usecase/item/fetch_my_items_usecase.dart';
import '../../domain/usecase/item/item_photo_usecase.dart';
import '../../domain/usecase/user/fetch_user_usecase.dart';
import '../models/items/create_item_model.dart';
import '../models/items/item_detail_model.dart';
import '../models/items/item_for _update.dart';
import '../models/items/item_model.dart';

abstract class ItemRemoteDataSource {
  Future<PaginationItemEntity> fetchItems(ItemsParams params);

  Future<ItemDetailEntity> fetchItemDetail(PathParams params);

  Future<List<CategoryEntity>> fetchCategories();

  Future<List<PlaceEntity>> fetchPlaceList();

  Future<PlaceEntity> createPlace(MapParams params);

  Future<List<IdNameEntity>> fetchConditionList();

  Future<List<IdNameEntity>> fetchPeriodTypes();

  Future<List<IdNameEntity>> fetchReturnTypes();

  Future<List<IdNameEntity>> fetchObtainTypes();

  Future<CreateItemEntity> createItem(MapParams params);

  Future<Map<String, dynamic>> updateItemPhoto(FormParams params);

  Future<Map<String, dynamic>> deleteItemPhoto(PathParams params);

  Future<PaginationMyItemEntity> fetchMyItems(PaginationParams params);

  Future<ItemForUpdateEntity> fetchItemUpdate(PathParams params);

  Future<ItemForUpdateEntity> changeItemData(PathMapParams params);

  Future<Map<String, dynamic>> changeItemStatus(PathParams params);

//  Future<AuthEntity> signIn(MapParams params);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final API api;

  ItemRemoteDataSourceImpl(this.api);



  @override
  Future<List<IdNameEntity>> fetchReturnTypes() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/return-type-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IdNameModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<IdNameEntity>> fetchObtainTypes() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/obtainment-type-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IdNameModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<CreateItemEntity> createItem(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}items/create/',
        data: params.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateItemModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateItemPhoto(FormParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}items/update-item-images/',
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
  Future<PaginationMyItemEntity> fetchMyItems(PaginationParams params) async {
    try {
      final response = await api.dio.get(params.status.isEmpty
          ? params.page <= 1
              ? '${constants.host}items/my/'
              : '${constants.host}items/my/?page=${params.page}'
          : params.page <= 1
              ? '${constants.host}items/my/?status=${params.status}'
              : '${constants.host}items/my/?page=${params.page}&status=${params.status}');

      if (response.statusCode == 200) {
        List<MyItemEntity> itemEntity = (response.data['results'] as List)
            .map((e) => MyItemModel.fromJson(e))
            .toList();
        return PaginationMyItemEntity(
            isLast: response.data['next'] == null, itemEntity: itemEntity);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<ItemForUpdateEntity> fetchItemUpdate(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}items/for-update/${params.path}/',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ItemForUpdateModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> changeItemStatus(PathParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}items/${params.path}/',
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<ItemForUpdateEntity> changeItemData(PathMapParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}items/for-update/${params.path}/',
        data: params.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ItemForUpdateModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteItemPhoto(PathParams params) async {
    try {
      final response = await api.dio.delete(
        '${constants.host}items/remove-image/${params.path}/',
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
