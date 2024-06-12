import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/categories_entity.dart';
import 'package:vprokat/src/domain/entity/items/my_items_entity.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchMyItemUseCase extends UseCase<PaginationMyItemEntity?, PaginationParams> {
  FetchMyItemUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, PaginationMyItemEntity>> call(PaginationParams? params) async {
    return await repository.fetchMyItems(params);
  }
}

class PaginationParams {
  const PaginationParams({required this.page, this.status = '',});

  final int page;
  final String status;

}
