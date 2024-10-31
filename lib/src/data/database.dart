import 'package:agtech/src/entities/product_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../core/utils/tables_db.dart';
import '../entities/user_entity.dart';

class DB {
  static final DB instance = DB._init();
  static Database? _database;

  DB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDB();
  }

  Future<Database> _initDB() async {
    final db = await getDatabasesPath();
    final path = join(db, 'agetch.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute(TablesDB.sqlUser);
    db.execute(TablesDB.sqlProduct);
    db.insert(TablesDB.tableProduct,
        {'name': 'Trator', 'description': 'Maquina de uso geral.'});
    db.insert(TablesDB.tableProduct,
        {'name': 'Colheitadeira', 'description': 'Maquina para colher cana.'});
    db.insert(TablesDB.tableProduct,
        {'name': 'Rocadeira', 'description': 'Maquina para rocar.'});
    db.insert(TablesDB.tableProduct,
        {'name': 'Aviao', 'description': 'Veiculo para uso geral.'});
    db.insert(TablesDB.tableProduct, {
      'name': 'Caminhao',
      'description': 'Veiculo para transporte de cargas.'
    });
  }

  //------------------------------------------------------------------
  //Consultas User

  Future<UserEntity?> login(UserEntity user) async {
    final db = await database;

    final result = await db.query(
      TablesDB.tableUser,
      where: 'email = ? AND password = ?',
      whereArgs: [
        user.email,
        user.password,
      ],
    );
    if (result.isNotEmpty) {
      return UserEntity.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<UserEntity?> signUp(UserEntity user) async {
    final db = await database;

    final result = await db.insert(
      TablesDB.tableUser,
      {
        'email': user.email,
        'password': user.password,
      },
    );

    if (result != 0) {
      return await login(user);
    } else {
      return null;
    }
  }

  //------------------------------------------------------------------
  //Consultas product

  Future<List<ProductEntity>?> getAllProducts() async {
    final db = await database;

    final result = await db.query(TablesDB.tableProduct);

    if (result.isNotEmpty) {
      return result.map((e) => ProductEntity.fromMap(e)).toList();
    }
    return null;
  }

  Future<bool> delProduct(ProductEntity product) async {
    final db = await database;

    final result = await db.delete(
      TablesDB.tableProduct,
      where: 'id = ?',
      whereArgs: [product.id],
    );

    if (result != 0) {
      return true;
    }
    return false;
  }

  Future<bool> addProduct(ProductEntity product) async {
    final db = await database;

    final result = await db.insert(
      TablesDB.tableProduct,
      {
        'name': product.name,
        'description': product.description,
      },
    );

    if (result != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProduct(ProductEntity product) async {
    final db = await database;

    final result = await db.update(
      TablesDB.tableProduct,
      {
        'name': product.name,
        'description': product.description,
      },
      where: 'id = ?',
      whereArgs: [product.id],
    );

    if (result != 0) {
      return true;
    } else {
      return false;
    }
  }
}
