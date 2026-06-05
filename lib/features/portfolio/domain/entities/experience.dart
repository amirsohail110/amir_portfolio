import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  const Experience({
    required this.id,
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.techStack,
    this.highlights = const [],
    this.companyUrl,
    this.isCurrent = false,
  });

  final String id;
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> techStack;
  final List<String> highlights;
  final String? companyUrl;
  final bool isCurrent;

  @override
  List<Object?> get props => [
        id,
        role,
        company,
        period,
        description,
        techStack,
        highlights,
        companyUrl,
        isCurrent,
      ];
}
