import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../models/Product.dart';
import '../../../repositories/ProductRepository.dart';
import '../../../utils/Route.dart';
import 'UpdateProductBloc.dart';

class UpdateProductScreen extends StatelessWidget {
  final Product product;

  const UpdateProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProductBloc>(
      create: (_) => UpdateProductBloc(
          product: product,
          productRepository: context.read<ProductRepository>())..initialForm(),
      child: _UpdateProductView(),
    );
  }
}

class _UpdateProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Update product"),
      ),
      body: _UpdateProductForm(),
    );
  }
}

class _UpdateProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProductBloc, UpdateProductState>(
      listener: (context, state) {
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
              _UpdateProductImagePicker(),
              const SizedBox(height: 16.0),
              _UpdateProductTitleInput(),
              const SizedBox(height: 16.0),
              _UpdateProductPriceInput(),
              const SizedBox(height: 16.0),
              _UpdateProductSubmitButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateProductImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
      if (state.imagePath.pure) {
        return GestureDetector(
          onTap: () => context.read<UpdateProductBloc>().pickImage(),
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

class _UpdateProductTitleInput extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
          _textEditingController.text = state.product!.title;
      return TextField(
        controller: _textEditingController,
        onChanged: (value) =>
            context.read<UpdateProductBloc>().titleChanged(value),
        decoration: InputDecoration(
          labelText: 'Title',
          errorText: state.title.invalid ? 'invalid title' : null,
        ),
      );
    });
  }
}

class _UpdateProductPriceInput extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
          _textEditingController.text = state.product!.title;
      return TextField(
        controller: _textEditingController,
        onChanged: (value) =>
            context.read<UpdateProductBloc>().priceChanged(value),
        decoration: InputDecoration(
          labelText: 'Price',
          errorText: state.price.invalid ? 'invalid price' : null,
        ),
      );
    });
  }
}

class _UpdateProductSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => context.read<UpdateProductBloc>().submitForm(),
      child: const Text('Update'),
    );
  }
}
