class EducationEntry {
  EducationEntry({this.degree = '', this.institute = '', this.year = '', this.score = ''});
  String degree;
  String institute;
  String year;
  String score;
}

class ExperienceEntry {
  ExperienceEntry({this.role = '', this.company = '', this.duration = '', this.description = ''});
  String role;
  String company;
  String duration;
  String description;
}

class ProjectEntry {
  ProjectEntry({this.name = '', this.description = '', this.link = ''});
  String name;
  String description;
  String link;
}

class ResumeData {
  String fullName = '';
  String jobTitle = '';
  String phone = '';
  String email = '';
  String city = '';
  String state = '';
  String country = '';
  String linkedIn = '';
  String portfolio = '';
  String github = '';
  final List<EducationEntry> education = [];
  final List<ExperienceEntry> experience = [];
  final List<ProjectEntry> projects = [];
  final List<String> skills = [];
}
