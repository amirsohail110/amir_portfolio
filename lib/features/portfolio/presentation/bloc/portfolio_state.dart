import 'package:equatable/equatable.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill_category.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

class PortfolioLoaded extends PortfolioState {
  const PortfolioLoaded({
    required this.experiences,
    required this.projects,
    required this.skillCategories,
  });

  final List<Experience> experiences;
  final List<Project> projects;
  final List<SkillCategory> skillCategories;

  @override
  List<Object?> get props => [experiences, projects, skillCategories];
}

class PortfolioError extends PortfolioState {
  const PortfolioError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
