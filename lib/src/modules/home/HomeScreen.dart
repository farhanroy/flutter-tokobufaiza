import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'HomeBloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: _HomeDrawer(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch(state.status) {
            case HomeStatus.DashboardScreen:
              return Text("Dashboard");
            case HomeStatus.AboutScreen:
              return Text("About");
            default:
              return Text("Empty");
          }
        }
      ),
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
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
              context.read<HomeBloc>().add(DashboardScreenEvent());
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              Navigator.pop(context);
              context.read<HomeBloc>().add(AboutScreenEvent());
            },
          )
        ],
      ),
    );
  }
}

