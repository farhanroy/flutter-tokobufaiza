import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/Route.dart';
import 'SearchProductBloc.dart';

class SearchProductDelegate extends SearchDelegate {
  final SearchProductBloc bloc;

  SearchProductDelegate(this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    if (this.query.isEmpty) {
      return <Widget>[];
    } else {
      return <Widget>[
        IconButton(icon: Icon(Icons.close), onPressed: () => query = '')
      ];
    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.searchProduct(query);
    return BlocListener<SearchProductBloc, SearchProductState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.status == SearchProductStatus.success) {
          showSuggestions(context);
        }
      },
      child: query.isEmpty
          ? Container()
          : ListView.builder(
              itemCount: bloc.state.products!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RouteName.DetailProductScreen,
                        arguments: ScreenArguments<int>(bloc.state.products![index].id)
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      bloc.state.products![index].title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
