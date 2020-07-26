import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final priceFocusNode = FocusNode();

  final descriptionFocusNode = FocusNode();

  final imageFocusNode = FocusNode();

  var titleController = TextEditingController();

  var priceController = TextEditingController();

  var descriptionController = TextEditingController();
  var imageUrlController = TextEditingController();
  bool hasArgument = false;
  bool saveForm(BuildContext context, String id) {
    if (imageUrlController.text.length == 0 ||
        descriptionController.text.length < 10 ||
        titleController.text.length == 0 ||
        double.tryParse(priceController.text) == null) {
      return false;
    }
    if (!hasArgument) {
      Provider.of<Products>(context, listen: false).addProduct(UniqueKey().toString(), titleController.text,
          double.parse(priceController.text), descriptionController.text, imageUrlController.text);
    } else {
      Provider.of<Products>(context, listen: false).updateProduct(id, titleController.text,
          double.parse(priceController.text), descriptionController.text, imageUrlController.text);
    }
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String id = "";
    if (ModalRoute.of(context).settings.arguments != null) {
      final args = ModalRoute.of(context).settings.arguments as Map<String, Object>;
      id = args['id'];
      titleController.text = args['title'];
      descriptionController.text = args['description'];
      priceController.text = args['price'].toString();
      imageUrlController.text = args['imageurl'];
      hasArgument = true;
    }

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            bool isSaved = saveForm(context, id);
            if (isSaved) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Product added Succesfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Something went wrong'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ));
            }
            Navigator.of(context).pop();
          },
          child: Icon(Icons.save),
        ),
      ),
      appBar: AppBar(
        title: Text('addd product'),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 3,
          left: 20,
          right: 20,
        ),
        child: Form(
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'title'),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                  controller: titleController,
                  validator: (value) {
                    if (double.tryParse(value) != null)
                      return 'Please enter a valid text';
                    else
                      return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'price'),
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  focusNode: priceFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(descriptionFocusNode);
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (double.tryParse(value) == null)
                      return 'Please enter a valid number';
                    else if (double.tryParse(value) <= 0)
                      return 'Please enter a number greater than 0';
                    else
                      return null;
                  },
                ),
              ),
              TextFormField(
                minLines: 2,
                maxLines: 2,
                maxLength: 100,
                decoration: InputDecoration(labelText: 'description'),
                controller: descriptionController,
                focusNode: descriptionFocusNode,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.length < 10) return 'The text should be at least ten characters long';
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(25),
                      width: 120,
                      height: 120,
                      child: imageUrlController.text.isEmpty
                          ? Text('image url cannot be empty')
                          : Image.network(
                              imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      controller: imageUrlController,
                      validator: (value) {
                        if (!value.startsWith('http') &&
                            !value.startsWith('https') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.gif') &&
                            !value.endsWith('.jpeg'))
                          return 'Please enter a valid url';
                        else
                          return null;
                      },
                      textInputAction: TextInputAction.done,
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
