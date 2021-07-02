import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/Product.dart';
import '../../../repositories/ProductRepository.dart';

enum DashboardProductStatus { initial, loading, success, failure }

class DashboardProductState extends Equatable {
  DashboardProductState({
    this.status = DashboardProductStatus.initial,
    List<Product>? products
  }): this.products = products;

  final DashboardProductStatus status;
  final List<Product>? products;

  DashboardProductState copyWith({
    DashboardProductStatus? status,
    List<Product>? products
  }) {
    return DashboardProductState(
        status: status ?? this.status,
        products: products ?? this.products
    );
  }

  @override
  List<Object?> get props => [status, products];
}

class DashboardProductBloc extends Cubit<DashboardProductState>{
  late ProductRepository _productRepository;

  DashboardProductBloc() : super(DashboardProductState()) {
    _productRepository = ProductRepository();
    getProducts();
  }

  Future<Product?> getProducts() async {
    emit(state.copyWith(status: DashboardProductStatus.loading));

    try {
      var _products = await _productRepository.getProducts();
      emit(state.copyWith(
          status: DashboardProductStatus.success,
        products: _products
      ));
    } on Exception {
      emit(state.copyWith(status: DashboardProductStatus.failure));
    }
  }
}