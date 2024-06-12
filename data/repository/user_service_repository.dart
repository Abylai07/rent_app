import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/user/auth_entity.dart';
import 'package:vprokat/src/domain/entity/user/city_entity.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';
import '../../domain/entity/user/user_entity.dart';
import '../../domain/repository/abstract_user_service_profile.dart';
import '../datasources/user_remote_data_source.dart';

class UserServiceRepositoryImpl extends AbstractUserServiceRepository {
  UserServiceRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final UserRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, UserEntity>> fetchUserInfo() async {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchUserInfo());
  }

  @override
  Future<Either<Failure, AuthEntity>> signIn(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signIn(params));
  }

  @override
  Future<Either<Failure, AuthEntity>> signUpCode(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpCode(params));
  }

  @override
  Future<Either<Failure, UserEntity>> signUpData(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpData(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpOtp(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpOtp(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpPassword(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpPassword(params));
  }

  @override
  Future<Either<Failure, List<CityEntity>>> fetchCityList() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchCityList());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteMe() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.deleteMe());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.logout());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> removeUserImage() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.removeUserImage());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateUserImage(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.updateUserImage(params));
  }
}
