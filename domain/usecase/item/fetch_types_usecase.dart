import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/id_name_entity.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchTypesUseCase {
  FetchTypesUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  Future<Either<Failure, List<IdNameEntity>>> fetchPeriods() async {
    return await repository.fetchPeriodType();
  }


  Future<Either<Failure, List<IdNameEntity>>> fetchReturns() async {
    return await repository.fetchReturnTypes();
  }

  Future<Either<Failure, List<IdNameEntity>>> fetchObtainment() async {
    return await repository.fetchObtainment();
  }
}



