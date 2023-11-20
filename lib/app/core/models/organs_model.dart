class OrgansModel {
  final String id;
  final String name;

  OrgansModel(this.id, this.name);

  factory OrgansModel.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        "id": final String id,
        "name": final String name,
      } =>
        OrgansModel(id, name),
      _ => throw ArgumentError(
          "Houve um erro em transformar o json num Organ Model")
    };
  }
}
