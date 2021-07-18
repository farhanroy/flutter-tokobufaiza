import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
      var pickedFile = await _picker.getImage(
        source: ImageSource.camera,
      );
      await compressFile(pickedFile!.path);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> compressFile(String filePath) async {
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitImage = filePath.substring(0, (lastIndex));
    final outPath = "${splitImage}_out${filePath.substring(lastIndex)}";
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 50,
      );
      print(result!.lengthSync());
      imagePathChanged(result.path);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> submitForm() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      int generatedId = DateTime.now().millisecondsSinceEpoch;
      var product = Product(
          id: generatedId,
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
