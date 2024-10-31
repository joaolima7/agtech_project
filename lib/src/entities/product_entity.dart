class ProductEntity {
  int? id;
  String name;
  String description;

  ProductEntity({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
