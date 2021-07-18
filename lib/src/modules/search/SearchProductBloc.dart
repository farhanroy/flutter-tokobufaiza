import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Product.dart';
import '../../repositories/ProductRepository.dart';

enum SearchProductStatus { initial, loading, success, failure }

class SearchProductState extends Equatable {

  SearchProductState({
    this.status = SearchProductStatus.initial,
    List<Product>? products
  }): this.products = products;

  final SearchProductStatus status;
  final List<Product>? products;

  SearchProductState copyWith({
    SearchProductStatus? status,
    List<Product>? products
  }) {
    return SearchProductState(
        status: status ?? this.status,
        products: products ?? this.products
    );
  }
  
  @override
  List<Object?> get props => [status, products];
}

class SearchProductBloc extends Cubit<SearchProductState>{
  SearchProductBloc(this.productRepository) : super(SearchProductState());

  final ProductRepository productRepository;

  Future<void> searchProduct(String query) async {
    if (query.isEmpty) return;
    emit(state.copyWith(status: SearchProductStatus.loading));
    try {
      var result = await productRepository.searchProduct(query);
      emit(state.copyWith(
        products: result,
          status: SearchProductStatus.success,
      ));
    } on Exception {
      emit(state.copyWith(status: SearchProductStatus.failure));
    }
  }
}