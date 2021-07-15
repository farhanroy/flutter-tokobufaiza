import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/EmptyComponent.dart';
import '../../../components/FailureComponent.dart';
import '../../../components/LoadingComponent.dart';
import '../../../models/Product.dart';
import '../../../repositories/ProductRepository.dart';
import 'DetailProductBloc.dart';

class DetailProductScreen extends StatelessWidget {
  final int id;

  const DetailProductScreen({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailProductBloc>(
      create: (_) => DetailProductBloc(
          id: id,
          productRepository: ProductRepository(),
      ),
      child: _DetailProductView(),
    );
  }
}

class _DetailProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Detail product"),
      ),
      body: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          if (state.status == DetailProductStatus.success) {
            return _PopulateDetailProduct(product: state.product!,);
          }
          else if (state.status == DetailProductStatus.loading) {
            return LoadingComponent();
          }
          else if (state.status == DetailProductStatus.failure) {
            return FailureComponent(message: "Error");
          }
          else {
            return EmptyComponent(message: "Empty");
          }
        }
      ),
    );
  }
}

class _PopulateDetailProduct extends StatelessWidget {
  final Product product;

  const _PopulateDetailProduct({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text(product.imagePath)
        ],
      ),
    );
  }
}
