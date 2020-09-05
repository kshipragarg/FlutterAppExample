import 'package:firstApp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class EditProduct extends StatefulWidget{
  // this line is suspect of we use final Products then the firs error goes
  // lib/Screens/edit_product.dart:8:9: Error: Type 'Product' not found.     
  // final Product product; 
  final Product product;
  
  EditProduct([this.product]);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct>{
  
  final nameController= TextEditingController();
  final priceController= TextEditingController();
  
  @override
  void dispose(){
	nameController.dispose();
	priceController.dispose();
	super.dispose();
  }
  
  @override
  void initState(){
	if(widget.product == null){
	  nameController.text="";
	  priceController.text="";
	  new Future.delayed(Duration.zero,(){
		final productProvider = Provider.of<ProductProvider>(context,listen: false);
		productProvider.loadValues(Product());
	  });
	}
	else{
	  nameController.text=widget.product.name;
	  priceController.text=widget.product.price.toString();
	  new Future.delayed(Duration.zero,(){
		final productProvider = Provider.of<ProductProvider>(context,listen: false);
		productProvider.loadValues(widget.product);
	  });

	}
	super.initState();
  }
  
  @override
  Widget build(BuildContext context){
		final productProvider = Provider.of<ProductProvider>(context);
		return Scaffold(
			appBar: AppBar(title: Text('Edit Product')),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: ListView(
					children: <Widget>[
						TextField(
							decoration: InputDecoration(hintText: 'Product Name'),
							onChanged:(value){
							productProvider.changeName(value);
							},
						),
						TextField(
							decoration: InputDecoration(hintText: 'Product Price'),
							onChanged:(value) => productProvider.changePrice(value),
						),
						SizedBox(height: 20.0,),
						RaisedButton(
							child: Text('Save'),
							onPressed: (){
							productProvider.saveProduct();
							Navigator.of(context).pop();
							},
						),
						(widget.product != null) ? RaisedButton(
							color: Colors.red,
							textColor: Colors.white,
							child: Text('Delete'),
							onPressed: (){
							productProvider.removeProduct(widget.product.productID);
							Navigator.of(context).pop();
							},
						): Container(),
					],
				),
			),
		);
  }
}