import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/entity/user/auth_entity.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_user_service_profile.dart';


class SignInUseCase extends UseCase<AuthEntity?, MapParams> {
  SignInUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, AuthEntity>> call(MapParams? params) async {
    return await repository.signIn(params);
  }
}

class MapParams extends Equatable{
  const MapParams(this.data);

  final Map<String, dynamic> data;
  @override
  List<Object> get props => [data];
}
