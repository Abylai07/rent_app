import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/item_detail_entity.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class CreatePlaceUseCase extends UseCase<PlaceEntity?, MapParams> {
  CreatePlaceUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, PlaceEntity>> call(MapParams? params) async {
    return await repository.createPlace(params);
  }
}


