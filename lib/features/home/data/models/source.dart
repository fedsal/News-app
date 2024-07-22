import 'package:news_app/features/home/domain/entities/source.dart';

class SourceModel extends SourceEntity {
  const SourceModel({super.id, super.name});

  factory SourceModel.fromJson(Map<String, dynamic> map) {
    return SourceModel(id: map['id'] ?? "", name: map['name'] ?? "");
  }

  factory SourceModel.fromEntity(SourceEntity entity) =>
      SourceModel(id: entity.id, name: entity.name);
}
