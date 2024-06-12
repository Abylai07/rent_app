import 'package:dartz/dartz.dart';
import 'package:vprokat/src/domain/repository/abstract_order_service_profile.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';


class BookItemUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  BookItemUseCase(this.repository);

  final AbstractOrderServiceRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.bookItem(params);
  }
}



