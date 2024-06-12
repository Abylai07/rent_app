import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../entity/user/user_entity.dart';
import '../../repository/abstract_user_service_profile.dart';


class FetchUserUseCase extends UseCase<UserEntity?, PathParams> {
  FetchUserUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(PathParams? params) async {
    return await repository.fetchUserInfo();
  }
}


class PathParams {
  const PathParams(this.path);

  final String path;
}
