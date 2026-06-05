import '../../domain/entities/skill_category.dart';

class SkillCategoryModel extends SkillCategory {
  const SkillCategoryModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.skills,
  });

  factory SkillCategoryModel.fromEntity(SkillCategory entity) {
    return SkillCategoryModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      skills: entity.skills,
    );
  }
}
