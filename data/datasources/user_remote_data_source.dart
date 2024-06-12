import 'package:dio/dio.dart';
import 'package:vprokat/src/data/models/user/city_model.dart';
import 'package:vprokat/src/domain/entity/user/auth_entity.dart';
import 'package:vprokat/src/domain/entity/user/city_entity.dart';
import 'package:vprokat/src/domain/entity/user/user_entity.dart';
import 'package:vprokat/src/domain/usecase/item/item_photo_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../models/user/auth_model.dart';
import '../models/user/user_info_model.dart';

abstract class UserRemoteDataSource {
  Future<UserEntity> fetchUserInfo();

  Future<List<CityEntity>> fetchCityList();

  Future<AuthEntity> signIn(MapParams params);

  Future<Map<String, dynamic>> signUpOtp(MapParams params);

  Future<AuthEntity> signUpCode(MapParams params);

  Future<UserEntity> signUpData(MapParams params);

  Future<Map<String, dynamic>> signUpPassword(MapParams params);

  Future<Map<String, dynamic>> deleteMe();

  Future<Map<String, dynamic>> logout();

  Future<Map<String, dynamic>> updateUserImage(FormParams params);

  Future<Map<String, dynamic>> removeUserImage();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final API api;

  UserRemoteDataSourceImpl(this.api);


  @override
  Future<UserEntity> fetchUserInfo() async {
    try {
      final response = await api.dio.get(
        '${constants.host}user/',
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<AuthEntity> signIn(MapParams params) async {
      try {
        final response = await api.dio.post(
          '${constants.host}user/',
          data: params.data,
        );

        if (response.statusCode == 200) {
          return AuthModel.fromJson(response.data);
        } else {
          throw ServerException();
        }
      } on DioException catch (e) {
        return api.handleDioException(e);
      }
  }

  @override
  Future<Map<String, dynamic>> signUpOtp(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<AuthEntity> signUpCode(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }


  @override
  Future<UserEntity> signUpData(MapParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}user/',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> signUpPassword(MapParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}user/',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<CityEntity>> fetchCityList() async {
    try {
      final response = await api.dio.get(
        '${constants.host}user/',
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => CityModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteMe() async {
    try {
      final response = await api.dio.delete(
        '${constants.host}user/',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/',
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
  Future<Map<String, dynamic>> removeUserImage() async {
    try {
      final response = await api.dio.delete(
        '${constants.host}user/',
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
  Future<Map<String, dynamic>> updateUserImage(FormParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}user/',
        data: params.data
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
}
