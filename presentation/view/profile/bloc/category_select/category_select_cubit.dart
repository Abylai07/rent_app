import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vprokat/src/domain/entity/items/categories_entity.dart';
import 'package:vprokat/src/domain/usecase/item/create_place_usecase.dart';
import 'package:vprokat/src/domain/usecase/user/sign_in_usecase.dart';

import '../../../../../domain/usecase/item/fetch_categories_usecase.dart';
import 'category_select_state.dart';

class CategorySelectCubit extends Cubit<CategorySelectState> {
  CategorySelectCubit(this.fetchCategoriesUseCase)
      : super(const CategorySelectState());

  final FetchCategoriesUseCase fetchCategoriesUseCase;

  void fetchCategories(int id) async {
    emit(const CategorySelectState(status: CategoryStatus.loading));

    final failureOrAuth = await fetchCategoriesUseCase(null);

    emit(
      failureOrAuth.fold(
          (l) => CategorySelectState(
                status: CategoryStatus.error,
                message: l.message,
              ), (r) {
        CategoryEntity? selectCategory;
        SubcategoryEntity? selectSubCategory;
        for (final category in r) {
          for (final subCategory in category.subcategories) {
            if (subCategory.id == id) {
              selectCategory = category;
              selectSubCategory = subCategory;
            }
          }
        }
        return CategorySelectState(
          status: CategoryStatus.success,
          entity: r,
          selectCategory: selectCategory,
          selectSubCategory: selectSubCategory,
        );
      }),
    );
  }

  selectCategory(CategoryEntity category) async {
    emit(state.copyWith(selectCategory: category, selectSubCategory: category.subcategories.first));
  }

  selectSubCategory(SubcategoryEntity category) async {
    emit(state.copyWith(selectSubCategory: category));
  }
  //
  // searchResult(List<GeocodingModel> list) async {
  //   emit(const CreatePlaceState(status: PlaceStatus.initial));
  //
  //   emit(CreatePlaceState(
  //     status: PlaceStatus.search,
  //     searchResult: list,
  //   ));
  // }
}
