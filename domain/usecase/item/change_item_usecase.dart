import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../entity/items/item_for _update.dart';
import '../../repository/abstract_item_service_profile.dart';


class ChangeItemUseCase{
  ChangeItemUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> changeItemStatus(PathParams? params) async {
    return await repository.changeItemStatus(params);
  }

  Future<Either<Failure, ItemForUpdateEntity>> changeItemData(PathMapParams? params) async {
    return await repository.changeItemData(params);
  }
}


class PathMapParams extends Equatable{
  const PathMapParams({required this.data, required this.path});

  final Map<String, dynamic> data;
  final String path;
  @override
  List<Object> get props => [data, path];
}