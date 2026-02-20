import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});
  @override
  State<ProductFormPage> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductFormPage> {
  final _focusPrice = FocusNode();
  final _focusDescription = FocusNode();
  final _focusUrlImage = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusUrlImage.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _focusPrice.dispose();
    _focusDescription.dispose();
    _focusUrlImage.dispose();
    _focusUrlImage.removeListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      //Pegando o prodeuto via modalRoute e preenchendo o _formData
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData["id"] = product.id;
        _formData["name"] = product.name;
        _formData["price"] = product.price;
        _formData["description"] = product.description;
        _formData["imageUrl"] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  void _updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endWithFile =
        url.toLowerCase().endsWith(".png") ||
        url.toLowerCase().endsWith(".jpg") ||
        url.toLowerCase().endsWith(".jpeg");

    return isValidUrl && endWithFile;
  }

  void _submitForm() {
    setState(() {
      isLoading = true;
    });
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    // final newProduct = Product(
    //   id: Random().nextDouble().toString(),
    //   name: _formData["name"].toString(),
    //   description: _formData["description"].toString(),
    //   price: double.parse(_formData["price"].toString()),
    //   imageUrl: _formData["imageUrl"].toString(),
    // );
    Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData)
        .catchError((error) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Ocorreu um erro"),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                ),
              ],
            ),
          );
        })
        .then((_) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário do produto"),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData["name"]?.toString(),
                      decoration: InputDecoration(
                        labelText: "Nome",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusPrice);
                      },
                      onSaved: (name) {
                        _formData["name"] = name ?? "";
                      },
                      validator: (_name) {
                        final name = _name ?? "";
                        if (name.trim().isEmpty) {
                          return "Nome é obrigatório";
                        }
                        if (name.trim().length < 3) {
                          return "O nome precisa ter 3 letras";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData["price"]?.toString(),
                      decoration: InputDecoration(
                        labelText: "Preço",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      focusNode: _focusPrice,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusDescription);
                      },
                      onSaved: (price) {
                        _formData["price"] = double.parse(price ?? "0");
                      },
                      validator: (_price) {
                        final price = _price ?? "";
                        if (price.trim().isEmpty) {
                          return "informe um preço válido";
                        }

                        try {
                          if (double.parse(price) >= 0) {
                            return null;
                          } else {
                            return "Informe um valor válido";
                          }
                        } catch (e) {
                          return "Formato de preço inválido (use . para separar casas decimais)";
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: _formData["description"]?.toString(),
                      decoration: InputDecoration(
                        labelText: "Descrição",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      //textInputAction: TextInputAction.next,
                      focusNode: _focusDescription,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) {
                        _formData["description"] = description ?? "";
                      },
                      validator: (_description) {
                        final description = _description ?? "";

                        if (description.trim().isEmpty) {
                          return "Descrição inválida";
                        } else if (description.trim().length < 3) {
                          return "Descrição precisa ter mais de 3 letras";
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _imageUrlController,
                            decoration: InputDecoration(
                              labelText: "URL da imagem",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            focusNode: _focusUrlImage,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (urlImage) {
                              _formData["imageUrl"] = urlImage ?? "";
                            },
                            validator: (_url) {
                              final url = _url ?? "";

                              if (url.trim().isEmpty) {
                                return "Url vazia";
                              }

                              if (isValidImageUrl(url)) {
                                return null;
                              } else {
                                return "Url inválida";
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text("Informe a url")
                              : FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(
                                    _imageUrlController.text,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
