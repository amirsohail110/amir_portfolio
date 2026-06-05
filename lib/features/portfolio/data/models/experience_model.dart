import '../../domain/entities/experience.dart';

class ExperienceModel extends Experience {
  const ExperienceModel({
    required super.id,
    required super.role,
    required super.company,
    required super.period,
    required super.description,
    required super.techStack,
    super.highlights,
    super.companyUrl,
    super.isCurrent,
  });

  factory ExperienceModel.fromEntity(Experience entity) {
    return ExperienceModel(
      id: entity.id,
      role: entity.role,
      company: entity.company,
      period: entity.period,
      description: entity.description,
      techStack: entity.techStack,
      highlights: entity.highlights,
      companyUrl: entity.companyUrl,
      isCurrent: entity.isCurrent,
    );
  }
}
