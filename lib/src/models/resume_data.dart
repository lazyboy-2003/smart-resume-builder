class EducationEntry {
  EducationEntry({this.degree='',this.institute='',this.year='',this.score=''});
  String degree,institute,year,score;
}
class ExperienceEntry {
  ExperienceEntry({this.role='',this.company='',this.duration='',this.description=''});
  String role,company,duration,description;
}
class ProjectEntry {
  ProjectEntry({this.name='',this.description='',this.link=''});
  String name,description,link;
}
class CertificationEntry {
  CertificationEntry({this.name='',this.issuer='',this.year=''});
  String name,issuer,year;
}
class ResumeData {
  String fullName='',jobTitle='',phone='',email='',city='',state='',country='';
  String linkedIn='',portfolio='',github='',summary='';
  final List<EducationEntry> education=[];
  final List<ExperienceEntry> experience=[];
  final List<ProjectEntry> projects=[];
  final List<CertificationEntry> certifications=[];
  final List<String> skills=[];
  final List<String> languages=[];
}
