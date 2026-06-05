import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.techStack,
    super.playStoreUrl,
    super.appStoreUrl,
    super.githubUrl,
    super.stars,
    super.isHighlighted,
  });

  factory ProjectModel.fromEntity(Project entity) {
    return ProjectModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      techStack: entity.techStack,
      playStoreUrl: entity.playStoreUrl,
      appStoreUrl: entity.appStoreUrl,
      githubUrl: entity.githubUrl,
      stars: entity.stars,
      isHighlighted: entity.isHighlighted,
    );
  }
}
