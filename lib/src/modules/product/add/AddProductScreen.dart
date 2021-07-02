import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../repositories/ProductRepository.dart';
import 'AddProductBloc.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductBloc>(
      create: (_) => AddProductBloc(productRepository: ProductRepository()),
      child: _AddProductView(),
    );
  }
}

class _AddProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add product"),
      ),
      body: _AddProductForm(),
    );
  }
}

class _AddProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {

        /// when submit form failure will showing snack bar
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentication Failure')),
          );
        }

        /// when submit form success will back to dashboard screen
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/product/dashboard', (route) => false);
        }

      },
      child: Column(
        children: [
          const SizedBox(height: 96.0),
          _AddProductTitleInput(),
          const SizedBox(height: 16.0),
          _AddProductSubmitButton()
        ],
      ),
    );
  }
}

class _AddProductTitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
      return TextField(
        onChanged: (value) =>
            context.read<AddProductBloc>().titleChanged(value),
        decoration: InputDecoration(
          labelText: 'Title',
          errorText: state.title.invalid ? 'invalid title' : null,
        ),
      );
    });
  }
}

class _AddProductSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => context.read<AddProductBloc>().submitForm(),
      child: const Text('Create'),
    );
  }
}
