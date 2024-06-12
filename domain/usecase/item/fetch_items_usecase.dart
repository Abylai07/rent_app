import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/item_entity.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchItemsUseCase extends UseCase<PaginationItemEntity?, ItemsParams> {
  FetchItemsUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, PaginationItemEntity>> call(ItemsParams? params) async {
    return await repository.fetchItems(params);
  }
}

class ItemsParams {
  const ItemsParams({required this.page, this.query = '', this.categoryId,});

  final String page;
  final String query;
  final int? categoryId;

}

