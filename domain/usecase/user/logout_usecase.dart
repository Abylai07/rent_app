import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/entity/user/auth_entity.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_user_service_profile.dart';


class LogOutUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  LogOutUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.logout();
  }
}

