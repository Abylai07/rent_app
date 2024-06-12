import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/entity/items/item_detail_entity.dart';

import '../../../../../../common/utils/geocoding/geocoding_model.dart';
import '../create_place/create_place_state.dart';


class PlaceListState<T> extends Equatable {
  const PlaceListState({
    this.status = PlaceStatus.initial,
    this.entity,
    this.selectPlace,
    this.multiSelect,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final PlaceStatus status;
  final List<PlaceEntity>? entity;
  final List<PlaceEntity>? multiSelect;
  final PlaceEntity? selectPlace;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    message,
    selectPlace,
    multiSelect,
    count,
    errorCode,
  ];

  PlaceListState copyWith({
    List<PlaceEntity>? entity,
    List<PlaceEntity>? multiSelect,
    PlaceEntity? selectPlace,
    PlaceStatus? status,
    String? message,
    List<GeocodingModel>? searchResult,
    int? count,
    int? errorCode,
  }) {
    return PlaceListState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      status: status ?? this.status,
      multiSelect: multiSelect ?? this.multiSelect,
      selectPlace: selectPlace ?? this.selectPlace,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
