import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/Product.dart';
import '../../../repositories/ProductRepository.dart';
import '../../../utils/Validators.dart';

class AddProductState extends Equatable {
  final DefaultValidator title;
  final DefaultValidator price;
  final DefaultValidator imagePath;
  final FormzStatus status;

  const AddProductState(
      {this.title = const DefaultValidator.pure(),
      this.price = const DefaultValidator.pure(),
      this.imagePath = const DefaultValidator.pure(),
      this.status = FormzStatus.pure});

  @override
  List<Object?> get props => [title, price, imagePath, status];

  AddProductState copyWith(
      {DefaultValidator? title,
      DefaultValidator? price,
      DefaultValidator? imagePath,
      FormzStatus? status}) {
    return AddProductState(
        title: title ?? this.title,
        price: price ?? this.price,
        imagePath: imagePath ?? this.imagePath,
        status: status ?? this.status);
  }
}

class AddProductBloc extends Cubit<AddProductState> {
  final ProductRepository productRepository;

  AddProductBloc({required this.productRepository})
      : super(const AddProductState());

  late PickedFile? pickedFile;

  void titleChanged(String value) {
    final title = DefaultValidator.dirty(value);
    emit(state.copyWith(
      title: title,
      price: state.price,
      imagePath: state.imagePath,
      status: Formz.validate([title]),
    ));
  }

  void priceChanged(String value) {
    final price = DefaultValidator.dirty(value);
    emit(state.copyWith(
      title: state.title,
      price: price,
      imagePath: state.imagePath,
      status: Formz.validate([price]),
    ));
  }

  void imagePathChanged(String value) {
    final imagePath = DefaultValidator.dirty(value);
    emit(state.copyWith(
      title: state.title,
      price: state.price,
      imagePath: imagePath,
      status: Formz.validate([imagePath]),
    ));
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      pickedFile = await _picker.getImage(source: ImageSource.camera);
      imagePathChanged(pickedFile!.path);
    } catch (e) {
      // TODO (adding exception when fail pick image)
    }
  }

  Future<void> submitForm() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      var product = Product(
          id: 0,
          title: state.title.value!,
          price: state.price.value!,
          imagePath: state.imagePath.value!);
      await productRepository.createProduct(product);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
