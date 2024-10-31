class TablesDB {
  static const tableUser = 'user';
  static const tableProduct = 'product';

  static const sqlUser = '''
    CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL
    );
''';

  static const sqlProduct = '''
    CREATE TABLE product(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL
    );
''';
}
