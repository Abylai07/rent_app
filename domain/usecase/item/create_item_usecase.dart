import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../entity/items/create_item_entity.dart';
import '../../repository/abstract_item_service_profile.dart';


class CreateItemUseCase extends UseCase<CreateItemEntity?, MapParams> {
  CreateItemUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, CreateItemEntity>> call(MapParams? params) async {
    return await repository.createItem(params);
  }
}


