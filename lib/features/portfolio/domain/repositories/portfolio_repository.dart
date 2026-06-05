import '../entities/experience.dart';
import '../entities/project.dart';
import '../entities/skill_category.dart';

abstract class PortfolioRepository {
  List<Experience> getExperiences();
  List<Project> getProjects();
  List<SkillCategory> getSkillCategories();
}
