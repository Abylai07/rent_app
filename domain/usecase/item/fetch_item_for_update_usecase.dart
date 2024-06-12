import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/item_entity.dart';
import 'package:vprokat/src/domain/entity/items/item_for%20_update.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchItemUpdateUseCase extends UseCase<ItemForUpdateEntity?, PathParams> {
  FetchItemUpdateUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, ItemForUpdateEntity>> call(PathParams? params) async {
    return await repository.fetchItemForUpdate(params);
  }
}



