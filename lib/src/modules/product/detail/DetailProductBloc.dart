import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/ProductRepository.dart';
import '../../../models/Product.dart';

enum DetailProductStatus { initial, success, loading, failure, successDelete }

class DetailProductState extends Equatable {
  final Product? product;
  final DetailProductStatus status;

  const DetailProductState({
    this.product,
    this.status = DetailProductStatus.initial
  });

  @override
  List<Object?> get props => [product, status];

  DetailProductState copyWith({
    Product? product,
    DetailProductStatus? status
  }) {
    return DetailProductState(
      product: product ?? this.product,
      status: status ?? this.status
    );
  }
}

class DetailProductBloc extends Cubit<DetailProductState> {
  final int id;
  final ProductRepository productRepository;

  DetailProductBloc({required this.id, required this.productRepository})
      : super(const DetailProductState()) { getDetailProduct(); }

  Future<void> getDetailProduct() async {
    emit(state.copyWith(status: DetailProductStatus.loading));
    try {
      var result = await productRepository.getDetailProduct(id);
      emit(state.copyWith(
          product: result,
          status: DetailProductStatus.success
      ));
    } on Exception {
      emit(state.copyWith(status: DetailProductStatus.failure));
    }
  }

  Future<void> updateProduct() async {
    emit(state.copyWith(status: DetailProductStatus.loading));
    try {
      var result = await productRepository.getDetailProduct(id);
      emit(state.copyWith(
          product: result,
          status: DetailProductStatus.success
      ));
    } on Exception {
      emit(state.copyWith(status: DetailProductStatus.failure));
    }
  }

  Future<void> deleteProduct() async {
    emit(state.copyWith(status: DetailProductStatus.loading));
    try {
      await productRepository.deleteProduct(id);
      emit(state.copyWith(
          status: DetailProductStatus.successDelete
      ));
    } on Exception {
      emit(state.copyWith(status: DetailProductStatus.failure));
    }
  }

}