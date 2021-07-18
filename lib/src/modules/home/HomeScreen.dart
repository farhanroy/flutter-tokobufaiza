import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search/SearchProductBloc.dart';
import '../../repositories/ProductRepository.dart';
import '../product/dashboard/DashboardProductScreen.dart';
import '../search/SearchProductDelegate.dart';
import 'HomeBloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<SearchProductBloc>(
          create: (_) => SearchProductBloc(
            context.read<ProductRepository>()
          ),
        ),
      ],
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(
                    context: context,
                    delegate: SearchProductDelegate(
                      context.read<SearchProductBloc>()
                    ),
                ),
          )
        ],
      ),
      drawer: _HomeDrawer(),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        switch (state.status) {
          case HomeStatus.ProductScreen:
            return DashboardProductScreen();
          case HomeStatus.SettingScreen:
            return Text("Setting");
          default:
            return Text("Empty");
        }
      }),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 8.0),
        children: <Widget>[
          DrawerHeader(child: Container()),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
              context.read<HomeBloc>().add(ProductEvent());
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              Navigator.pop(context);
              context.read<HomeBloc>().add(SettingEvent());
            },
          )
        ],
      ),
    );
  }
}
