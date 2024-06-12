import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/user/auth_entity.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../entity/user/user_entity.dart';
import '../../repository/abstract_user_service_profile.dart';


class SignOtpUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  SignOtpUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.signUpOtp(params);
  }
}

class SignVerifyUseCase extends UseCase<AuthEntity?, MapParams> {
  SignVerifyUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, AuthEntity>> call(MapParams? params) async {
    return await repository.signUpCode(params);
  }
}


class SignDataUseCase extends UseCase<UserEntity?, MapParams> {
  SignDataUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(MapParams? params) async {
    return await repository.signUpData(params);
  }
}

class SignPasswordUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  SignPasswordUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.signUpPassword(params);
  }
}


