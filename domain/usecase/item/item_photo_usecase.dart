import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class ItemPhotoUseCase {
  ItemPhotoUseCase(this.repository);

  final AbstractItemServiceRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> updateItemPhoto(FormParams? params) async {
    return await repository.updateItemPhoto(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteItemPhoto(PathParams? params) async {
    return await repository.deleteItemPhoto(params);
  }
}

class FormParams extends Equatable{
  const FormParams(this.data);

  final FormData data;
  @override
  List<Object> get props => [data];
}