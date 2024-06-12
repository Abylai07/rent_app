import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/user/city_entity.dart';

import '../../core/error/failure.dart';
import '../entity/user/auth_entity.dart';
import '../entity/user/user_entity.dart';

abstract class AbstractUserServiceRepository {

  Future<Either<Failure, UserEntity>> fetchUserInfo();

  Future<Either<Failure, List<CityEntity>>> fetchCityList();

  Future<Either<Failure, AuthEntity>> signIn(params);

  Future<Either<Failure, Map<String, dynamic>>> signUpOtp(params);

  Future<Either<Failure, AuthEntity>> signUpCode(params);

  Future<Either<Failure, UserEntity>> signUpData(params);

  Future<Either<Failure, Map<String, dynamic>>> signUpPassword(params);

  Future<Either<Failure, Map<String, dynamic>>> deleteMe();

  Future<Either<Failure, Map<String, dynamic>>> logout();

  Future<Either<Failure, Map<String, dynamic>>> updateUserImage(params);

  Future<Either<Failure, Map<String, dynamic>>> removeUserImage();

}