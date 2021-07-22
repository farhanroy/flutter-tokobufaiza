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
          productRepository: context.read<ProductRepository>())
        ..initialForm(),
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

  final TextEditingController _inputTitle = TextEditingController();
  final TextEditingController _inputPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setInitialValue(context);
    return BlocListener<UpdateProductBloc, UpdateProductState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.HomeScreen, (route) => false);
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Update Failure')),
            );
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
              _UpdateProductTitleInput(inputTitle: _inputTitle,),
              const SizedBox(height: 16.0),
              _UpdateProductPriceInput(inputPrice: _inputPrice,),
              const SizedBox(height: 16.0),
              _UpdateProductSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  void setInitialValue(BuildContext context) {
    var product = context.read<UpdateProductBloc>().product;
    _inputTitle.text = product.title;
    _inputPrice.text = product.price;

    context.read<UpdateProductBloc>().initialForm();
  }
}

class _UpdateProductImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
      if (!state.imagePath.pure) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(96.0),
              child: Image.file(
                File(state.imagePath.value!),
                fit: BoxFit.fill,
                width: maxWidth / 2,
                height: maxWidth / 2,
              ),
            ),
            FloatingActionButton(

              backgroundColor: theme.scaffoldBackgroundColor,
              child: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () =>
                  context.read<UpdateProductBloc>().deleteImage(),
            )
          ],
        );
      } else {
        return GestureDetector(
          onTap: () => context.read<UpdateProductBloc>().pickImage(),
          child: Container(
            width: maxWidth/2,
            height: maxWidth/2,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(96.0),
              color: Colors.grey,
            ),
            child: Icon(
              Icons.add_a_photo,
              color: Colors.black54,
            ),
          ),
        );
      }
    });
  }
}

class _UpdateProductTitleInput extends StatelessWidget {
  final TextEditingController? inputTitle;

  const _UpdateProductTitleInput({Key? key, this.inputTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
      return TextField(
        controller: inputTitle,
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
  final TextEditingController? inputPrice;

  const _UpdateProductPriceInput({Key? key, this.inputPrice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
      return TextField(
        controller: inputPrice,
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
