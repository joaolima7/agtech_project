import 'package:agtech/src/data/database.dart';
import 'package:get/get.dart';

import '../entities/product_entity.dart';

class ProductController extends GetxController {
  final _db = DB.instance;
  RxBool isLoading = false.obs;
  RxList<ProductEntity> products = <ProductEntity>[].obs;

  Future<void> getAllProducts() async {
    isLoading.value = true;
    try {
      final result = await _db.getAllProducts();

      if (result != null) {
        products = result.obs;
      } else {
        products.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addProduct(ProductEntity product) async {
    final db = DB.instance;
    isLoading.value = true;

    try {
      final result = await db.addProduct(product);

      if (result) {
        return true;
      } else {
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProduct(ProductEntity product) async {
    final db = DB.instance;
    isLoading.value = true;

    try {
      final result = await db.updateProduct(product);

      if (result) {
        return true;
      } else {
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> delProduct(ProductEntity product) async {
    final db = DB.instance;
    isLoading.value = true;

    try {
      final result = await db.delProduct(product);

      if (result) {
        await getAllProducts();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
