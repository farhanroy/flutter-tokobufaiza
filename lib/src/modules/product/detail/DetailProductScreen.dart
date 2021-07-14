import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/EmptyComponent.dart';
import '../../../components/FailureComponent.dart';
import '../../../components/LoadingComponent.dart';
import 'DetailProductBloc.dart';
import '../../../repositories/ProductRepository.dart';

class DetailProductScreen extends StatelessWidget {
  final int id;

  const DetailProductScreen({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailProductBloc>(
      create: (_) => DetailProductBloc(productRepository: ProductRepository()),
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
            return _PopulateDetailProduct();
          }
          else if (state.status == DetailProductStatus.loading) {
            return LoadingComponent();
          }
          else if (state.status == DetailProductStatus.failure) {
            return FailureComponent(message: "");
          }
          else {
            return EmptyComponent(message: "");
          }
        }
      ),
    );
  }
}

class _PopulateDetailProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [

        ],
      ),
    );
  }
}


