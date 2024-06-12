import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/entity/items/categories_entity.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchCategoriesUseCase extends UseCase<List<CategoryEntity>?, PathParams> {
  FetchCategoriesUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(PathParams? params) async {
    return await repository.fetchCategories(params);
  }
}

