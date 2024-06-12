import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/repository/abstract_user_service_profile.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';
import '../item/item_photo_usecase.dart';


class UserPhotoUseCase {
  UserPhotoUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> updateUserImage(FormParams? params) async {
    return await repository.updateUserImage(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> removeUserImage() async {
    return await repository.removeUserImage();
  }
}

