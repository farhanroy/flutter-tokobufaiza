import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/EmptyComponent.dart';
import '../../../components/FailureComponent.dart';
import '../../../components/LoadingComponent.dart';
import '../../../models/Product.dart';
import '../../../repositories/ProductRepository.dart';
import '../../../utils/Route.dart';
import 'DetailProductBloc.dart';

class DetailProductScreen extends StatelessWidget {
  final int id;

  const DetailProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailProductBloc>(
      create: (_) => DetailProductBloc(
        id: id,
        productRepository: context.read<ProductRepository>(),
      ),
      child: _DetailProductView(),
    );
  }
}

class _DetailProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailProductBloc, DetailProductState>(
      listener: (context, state) {
        if (state.status == DetailProductStatus.successDelete) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.HomeScreen, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Detail product"),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _showDeleteDialog(context)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, RouteName.UpdateProductScreen,
                arguments: ScreenArguments(context.read<DetailProductBloc>().state.product!));
          },
        ),
        body: BlocBuilder<DetailProductBloc, DetailProductState>(
            builder: (context, state) {
          if (state.status == DetailProductStatus.success) {
            return _PopulateDetailProduct(
              product: state.product!,
            );
          } else if (state.status == DetailProductStatus.loading) {
            return LoadingComponent();
          } else if (state.status == DetailProductStatus.failure) {
            return FailureComponent(message: "Error");
          } else {
            return EmptyComponent(message: "Empty");
          }
        }),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    final bloc = BlocProvider.of<DetailProductBloc>(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete product"),
          content: const Text("Are you sure to delete product ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                bloc.deleteProduct();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: Colors.redAccent),),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

class _PopulateDetailProduct extends StatelessWidget {
  final Product product;

  const _PopulateDetailProduct({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    File imagePath = File(product.imagePath);
    final maxWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(96.0),
            child: Image.file(
              File(imagePath.path),
              fit: BoxFit.fill,
              width: maxWidth / 2,
              height: maxWidth / 2,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Product'),
              Text(product.title,),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Price'),
              Text(product.price),
            ],
          ),
        ],
      ),
    );
  }
}
