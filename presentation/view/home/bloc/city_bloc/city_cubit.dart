import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/common/enums.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_city_usecase.dart';

import '../../../../../domain/entity/user/city_entity.dart';
import '../../../../bloc/base_state.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.fetchCityUseCase) : super(const CityState());

  final FetchCityUseCase fetchCityUseCase;

  void fetchCityList() async {
    emit(const CityState(status: CubitStatus.loading));

    final failureOrAuth = await fetchCityUseCase(null);

    emit(
      failureOrAuth.fold(
        (l) => CityState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => CityState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  selectCity(CityEntity? city) {
    emit(state.copyWith(selectCity: city));
  }
}
