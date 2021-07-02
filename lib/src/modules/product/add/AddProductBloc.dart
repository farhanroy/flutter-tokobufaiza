import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../models/Product.dart';
import '../../../repositories/ProductRepository.dart';
import '../../../utils/Validators.dart';

class AddProductState extends Equatable {
  final DefaultValidator title;
  final FormzStatus status;

  const AddProductState({
    this.title = const DefaultValidator.pure(),
    this.status = FormzStatus.pure
  });

  @override
  List<Object?> get props => [title, status];

  AddProductState copyWith({
    DefaultValidator? title,
    FormzStatus? status
  }) {
    return AddProductState(
      title: title ?? this.title,
      status: status ?? this.status
    );
  }
}

class AddProductBloc extends Cubit<AddProductState> {
  AddProductBloc({required this.productRepository}) : super(const AddProductState());

  final ProductRepository productRepository;

  void titleChanged(String value) {
    final title = DefaultValidator.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title]),
    ));
  }


  Future<void> submitForm() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      var product = Product(id: 0, title: state.title.value!);
      await productRepository.createProduct(product);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }

  }

}