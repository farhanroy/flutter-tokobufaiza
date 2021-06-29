import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DashboardProductBloc.dart';

class DashboardProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardProductBloc>(
      create: (_) => DashboardProductBloc(),
      child: _DashboardProductView(),
    );
  }
}

class _DashboardProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<DashboardProductBloc, DashboardProductState>(
        builder: (context, state) {
          switch(state.status) {
            case DashboardProductStatus.loading:
              return const Center(child: CircularProgressIndicator(),);
            case DashboardProductStatus.failure:
              return const Text("Error");
            default:
              return const Text("Kosong");
          }
        },
      ),
    );
  }
}
