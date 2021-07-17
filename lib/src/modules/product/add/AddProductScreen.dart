import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/Route.dart';
import '../../../repositories/ProductRepository.dart';
import 'AddProductBloc.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductBloc>(
      create: (_) => AddProductBloc(
          productRepository: context.read<ProductRepository>()
      ),
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
            const SnackBar(content: Text('Add product failure')),
          );
        }

        /// when submit form success will back to dashboard screen
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.HomeScreen, (route) => false);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 54.0),
              _AddProductImagePicker(),
              const SizedBox(height: 16.0),
              _AddProductTitleInput(),
              const SizedBox(height: 16.0),
              _AddProductPriceInput(),
              const SizedBox(height: 16.0),
              _AddProductSubmitButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _AddProductImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
      if (state.imagePath.pure) {
        return GestureDetector(
          onTap: () => context.read<AddProductBloc>().pickImage(),
          child: Container(
            width: maxWidth,
            height: 300.0,
            color: Colors.grey,
            child: Icon(
              Icons.add_a_photo,
              color: Colors.black54,
            ),
          ),
        );
      } else {
        return Image.file(File(state.imagePath.value!));
      }
    });
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

class _AddProductPriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
      return TextField(
        onChanged: (value) =>
            context.read<AddProductBloc>().priceChanged(value),
        decoration: InputDecoration(
          labelText: 'Price',
          errorText: state.price.invalid ? 'invalid price' : null,
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
