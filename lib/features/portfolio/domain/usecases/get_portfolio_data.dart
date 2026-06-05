import '../entities/experience.dart';
import '../entities/project.dart';
import '../entities/skill_category.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolioData {
  const GetPortfolioData(this._repository);

  final PortfolioRepository _repository;

  List<Experience> getExperiences() => _repository.getExperiences();
  List<Project> getProjects() => _repository.getProjects();
  List<SkillCategory> getSkillCategories() => _repository.getSkillCategories();
}
