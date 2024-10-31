import 'package:agtech/src/controller/product_controller.dart';
import 'package:agtech/src/controller/user_controller.dart';
import 'package:get_it/get_it.dart';

class Inject {
  static void init() async {
    final getIt = GetIt.I;

    getIt.registerLazySingleton<UserController>(() => UserController());
    getIt.registerLazySingleton<ProductController>(() => ProductController());
  }
}
