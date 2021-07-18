import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/ProductRepository.dart';
import '../../../components/EmptyComponent.dart';
import '../../../components/FailureComponent.dart';
import '../../../components/LoadingComponent.dart';
import '../../../models/Product.dart';
import '../../../utils/Route.dart';
import 'DashboardProductBloc.dart';

class DashboardProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardProductBloc>(
      create: (_) => DashboardProductBloc(
        context.read<ProductRepository>()
      ),
      child: _DashboardProductView(),
    );
  }
}

class _DashboardProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.AddProductScreen);
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<DashboardProductBloc, DashboardProductState>(
        builder: (context, state) {
          switch (state.status) {
            case DashboardProductStatus.loading:
              return LoadingComponent();
            case DashboardProductStatus.failure:
              return FailureComponent(
                message: "Failure",
              );
            case DashboardProductStatus.success:
              return _DashboardProductList(products: state.products!);
            default:
              return const EmptyComponent(message: "Empty");
          }
        },
      ),
    );
  }
}

class _DashboardProductList extends StatelessWidget {
  final List<Product> products;

  const _DashboardProductList({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var imagePath = File(products[index].imagePath);
          return ListTile(
            leading: Image.file(imagePath),
            title: Text(products[index].title),
            subtitle: Text(products[index].price),
            onTap: () {
              Navigator.of(context).pushNamed(
                  RouteName.DetailProductScreen,
                  arguments: ScreenArguments<int>(products[index].id)
              );
            },
          );
        });
  }
}
