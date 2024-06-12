import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/id_name_entity.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchConditionUseCase {
  FetchConditionUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  Future<Either<Failure, List<IdNameEntity>>> fetchConditions() async {
    return await repository.fetchConditionList();
  }
}



