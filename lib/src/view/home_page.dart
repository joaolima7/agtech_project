import 'package:agtech/src/controller/product_controller.dart';
import 'package:agtech/src/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../components/custom_dialog.dart';
import '../controller/user_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _users = GetIt.I.get<UserController>();
  final _productController = GetIt.I.get<ProductController>();

  _load() async {
    await _productController.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    _load();
    return Scaffold(
      appBar: AppBar(
        title: const Text('AGTech'),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        actions: [
          IconButton(
            onPressed: () async {
              await _users.logout(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            if (_productController.isLoading.value)
              return const Center(
                child: CircularProgressIndicator(),
              );

            if (_productController.products.isEmpty)
              return const Center(
                child: Text('Nenhum usuário encomtrado!'),
              );
            else {
              return ListView.builder(
                itemCount: _productController.products.length,
                itemBuilder: (context, index) {
                  final product = _productController.products[index];
                  final descriptionController =
                      TextEditingController(text: product.description);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      color: Colors.white60,
                      child: ListTile(
                        title:
                            Text('ID: ${product.id}\nMáquina: ${product.name}'),
                        subtitle: Text('Descrição: ${product.description}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showEditDialog(
                                    context, product, descriptionController);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showDeleteDialog(context, product);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newProduct = ProductEntity(name: '', description: '');
          final descriptionController = TextEditingController();
          final nameController = TextEditingController();
          _showAddDialog(
              context, newProduct, descriptionController, nameController);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade300,
      ),
    );
  }

  void _showEditDialog(BuildContext context, ProductEntity productUp,
      TextEditingController descriptionController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Editar Máquina',
          message: '',
          confirmButtonText: 'Salvar',
          cancelButtonText: 'Cancelar',
          onConfirm: () {
            _productController.updateProduct(productUp);
          },
          isEditMode: true,
          textController: descriptionController,
        );
      },
    );
  }

  void _showAddDialog(
      BuildContext context,
      ProductEntity productNew,
      TextEditingController descriptionController,
      TextEditingController nameController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Adicionar Produto',
          message: 'Adicione um Produto',
          confirmButtonText: 'Salvar',
          cancelButtonText: 'Cancelar',
          onConfirm: () async {
            productNew.description = descriptionController.text;
            productNew.name = nameController.text;
            await _productController.addProduct(productNew);
            await _productController.getAllProducts();
          },
          isEditMode: true,
          textController: descriptionController,
          nameController: nameController,
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, ProductEntity productDel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Confirmar Exclusão',
          message: 'Tem certeza que deseja excluir o usuário?',
          confirmButtonText: 'Excluir',
          cancelButtonText: 'Cancelar',
          onConfirm: () {
            _productController.delProduct(productDel);
          },
        );
      },
    );
  }
}
