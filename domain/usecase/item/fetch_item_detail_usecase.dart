import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../entity/items/item_detail_entity.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchItemDetailUseCase extends UseCase<ItemDetailEntity?, PathParams> {
  FetchItemDetailUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, ItemDetailEntity>> call(PathParams? params) async {
    return await repository.fetchItemDetail(params);
  }
}


