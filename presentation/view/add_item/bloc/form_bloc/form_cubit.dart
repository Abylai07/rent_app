import 'package:bloc/bloc.dart';
import 'package:vprokat/src/presentation/view/add_item/bloc/form_bloc/form_state.dart';

class FormStateCubit extends Cubit<FormState> {
  FormStateCubit() : super(const FormState(inputValue: '', isError: false));

  void updateInputValue(String value) {
    emit(state.copyWith(inputValue: value, isError: false));
  }

  void showError() {
    emit(state.copyWith(isError: true));
  }
}
