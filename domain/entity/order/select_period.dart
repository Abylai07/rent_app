import 'package:equatable/equatable.dart';
import 'package:vprokat/src/domain/entity/items/id_name_entity.dart';

class SelectPeriod extends Equatable{
  IdNameEntity period;
  String? price;

  SelectPeriod({required this.period, this.price});

  @override
  List<Object?> get props => [period, price];
}