import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vprokat/src/data/datasources/item_remote_data_source.dart';
import 'package:vprokat/src/data/datasources/order_remote_data_source.dart';
import 'package:vprokat/src/domain/repository/abstract_item_service_profile.dart';
import 'package:vprokat/src/domain/repository/abstract_order_service_profile.dart';
import 'package:vprokat/src/domain/usecase/item/create_place_usecase.dart';
import 'package:vprokat/src/domain/usecase/item/fetch_item_for_update_usecase.dart';
import 'package:vprokat/src/domain/usecase/item/fetch_items_usecase.dart';
import 'package:vprokat/src/domain/usecase/item/fetch_my_items_usecase.dart';
import 'package:vprokat/src/domain/usecase/item/fetch_places_usecase.dart';
import 'package:vprokat/src/domain/usecase/item/item_photo_usecase.dart';
import 'package:vprokat/src/domain/usecase/order/book_item_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/fetch_user_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/logout_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:vprokat/src/platform/network_info.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/create_item_cubit.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/item_photo_cubit.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/select_condition_bloc/condition_cubit.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/select_obtainment_bloc/obtainment_cubit.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/select_period_bloc/period_cubit.dart';
import 'package:vprokat/src/presentation/view/authorization/sign_in/bloc/sign_in_cubit.dart';
import 'package:vprokat/src/presentation/view/authorization/sign_up/bloc/sign_up_cubit.dart';
import 'package:vprokat/src/presentation/view/categories/bloc/category_items_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/book_item_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/category_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/item_detail_cubit.dart';
import 'package:vprokat/src/presentation/view/home/bloc/items_cubit.dart';
import 'package:vprokat/src/presentation/view/home/item_card/bloc/create_place/create_place_cubit.dart';
import 'package:vprokat/src/presentation/view/home/item_card/bloc/place_list/place_list_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/category_select/category_select_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/change_item_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/delete_me_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/item_update_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/my_item_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/my_orders/my_orders_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/status_count/status_count_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/user_info_cubit.dart';
import 'package:vprokat/src/presentation/view/profile/bloc/user_photo_cubit.dart';

import 'common/api.dart';
import 'core/check_error_type.dart';
import 'data/datasources/user_remote_data_source.dart';
import 'data/repository/item_service_repository.dart';
import 'data/repository/order_service_repository.dart';
import 'data/repository/user_service_repository.dart';
import 'domain/repository/abstract_user_service_profile.dart';
import 'domain/usecase/item/change_item_usecase.dart';
import 'domain/usecase/item/create_item_usecase.dart';
import 'domain/usecase/item/fetch_categories_usecase.dart';
import 'domain/usecase/item/fetch_condition_usecase.dart';
import 'domain/usecase/item/fetch_item_detail_usecase.dart';
import 'domain/usecase/item/fetch_types_usecase.dart';
import 'domain/usecase/order/order_item_usecase.dart';
import 'domain/usecase/order/status_count_usecase.dart';
import 'domain/usecase/user/delete_me_usecase.dart';
import 'domain/usecase/user/fetch_city_usecase.dart';
import 'domain/usecase/user/sign_up_usecase.dart';
import 'domain/usecase/user/user_photo_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NetworkOperationHelper>(() => NetworkOperationHelper(sl()));

  //BLoCs
  sl.registerFactory(() => SingInCubit(sl(), sl()));
  sl.registerFactory(() => SignUpCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UserInfoCubit(sl()));
  sl.registerFactory(() => CityCubit(sl()));
  sl.registerFactory(() => DeleteMeCubit(sl()));
  sl.registerFactory(() => UserPhotoCubit(sl()));

  sl.registerFactory(() => ItemsCubit(sl()));
  sl.registerFactory(() => CategoryCubit(sl()));
  sl.registerFactory(() => ItemDetailCubit(sl()));
  sl.registerFactory(() => CategoryItemsCubit(sl()));
  sl.registerFactory(() => PlaceListCubit(sl()));
  sl.registerFactory(() => CreatePlaceCubit(sl()));
  sl.registerFactory(() => PeriodSelectCubit(sl()));
  sl.registerFactory(() => ConditionSelectCubit(sl()));
  sl.registerFactory(() => ObtainmentSelectCubit(sl()));
  sl.registerFactory(() => CreateItemCubit(sl()));
  sl.registerFactory(() => ItemPhotoCubit(sl()));
  sl.registerFactory(() => MyItemCubit(sl()));
  sl.registerFactory(() => ItemUpdateCubit(sl()));
  sl.registerFactory(() => ChangeItemCubit(sl(), sl()));
  sl.registerFactory(() => CategorySelectCubit(sl()));

  sl.registerFactory(() => BookItemCubit(sl()));
  sl.registerFactory(() => MyOrdersCubit(sl()));
  sl.registerFactory(() => StatusCountCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => FetchUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOtpUseCase(sl()));
  sl.registerLazySingleton(() => SignVerifyUseCase(sl()));
  sl.registerLazySingleton(() => SignDataUseCase(sl()));
  sl.registerLazySingleton(() => SignPasswordUseCase(sl()));
  sl.registerLazySingleton(() => FetchCityUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMeUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => UserPhotoUseCase(sl()));

  sl.registerLazySingleton(() => FetchItemsUseCase(sl()));
  sl.registerLazySingleton(() => FetchCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => FetchItemDetailUseCase(sl()));
  sl.registerLazySingleton(() => FetchPlacesUseCase(sl()));
  sl.registerLazySingleton(() => CreatePlaceUseCase(sl()));
  sl.registerLazySingleton(() => FetchTypesUseCase(sl()));
  sl.registerLazySingleton(() => FetchConditionUseCase(sl()));
  sl.registerLazySingleton(() => CreateItemUseCase(sl()));
  sl.registerLazySingleton(() => ItemPhotoUseCase(sl()));
  sl.registerLazySingleton(() => FetchMyItemUseCase(sl()));
  sl.registerLazySingleton(() => FetchItemUpdateUseCase(sl()));
  sl.registerLazySingleton(() => ChangeItemUseCase(sl()));

  sl.registerLazySingleton(() => BookItemUseCase(sl()));
  sl.registerLazySingleton(() => OrderItemUseCase(sl()));
  sl.registerLazySingleton(() => StatusCountUseCase(sl()));

 // Remote Repositories
  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ItemRemoteDataSource>(
        () => ItemRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSourceImpl(sl()),
  );

 // Service Repositories
  sl.registerLazySingleton<AbstractUserServiceRepository>(
        () => UserServiceRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<AbstractItemServiceRepository>(
        () => ItemServiceRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AbstractOrderServiceRepository>(
        () => OrderServiceRepositoryImpl(sl(), sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => API());
    sl.registerLazySingleton(() => InternetConnectionChecker());
}
