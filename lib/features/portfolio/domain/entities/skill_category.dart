import 'package:equatable/equatable.dart';

class SkillCategory extends Equatable {
  const SkillCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.skills,
  });

  final String id;
  final String name;
  final String icon;
  final List<String> skills;

  @override
  List<Object?> get props => [id, name, icon, skills];
}
