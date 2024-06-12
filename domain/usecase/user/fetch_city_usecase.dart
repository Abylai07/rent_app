import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/user/city_entity.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_user_service_profile.dart';
import 'fetch_user_usecase.dart';


class FetchCityUseCase extends UseCase<List<CityEntity>?, PathParams> {
  FetchCityUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, List<CityEntity>>> call(PathParams? params) async {
    return await repository.fetchCityList();
  }
}

