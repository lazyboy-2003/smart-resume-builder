import 'dart:convert';

class EducationEntry {
  EducationEntry({this.degree='',this.institute='',this.year='',this.score=''});
  String degree,institute,year,score;
  Map<String,dynamic> toJson()=>{'degree':degree,'institute':institute,'year':year,'score':score};
  factory EducationEntry.fromJson(Map<String,dynamic> j)=>EducationEntry(degree:j['degree']??'',institute:j['institute']??'',year:j['year']??'',score:j['score']??'');
}
class ExperienceEntry {
  ExperienceEntry({this.role='',this.company='',this.duration='',this.description=''});
  String role,company,duration,description;
  Map<String,dynamic> toJson()=>{'role':role,'company':company,'duration':duration,'description':description};
  factory ExperienceEntry.fromJson(Map<String,dynamic> j)=>ExperienceEntry(role:j['role']??'',company:j['company']??'',duration:j['duration']??'',description:j['description']??'');
}
class ProjectEntry {
  ProjectEntry({this.name='',this.description='',this.link=''});
  String name,description,link;
  Map<String,dynamic> toJson()=>{'name':name,'description':description,'link':link};
  factory ProjectEntry.fromJson(Map<String,dynamic> j)=>ProjectEntry(name:j['name']??'',description:j['description']??'',link:j['link']??'');
}
class CertificationEntry {
  CertificationEntry({this.name='',this.issuer='',this.year=''});
  String name,issuer,year;
  Map<String,dynamic> toJson()=>{'name':name,'issuer':issuer,'year':year};
  factory CertificationEntry.fromJson(Map<String,dynamic> j)=>CertificationEntry(name:j['name']??'',issuer:j['issuer']??'',year:j['year']??'');
}
class ResumeData {
  ResumeData({String? id}):id=id??DateTime.now().microsecondsSinceEpoch.toString();
  String id;
  String fullName='',jobTitle='',phone='',email='',city='',state='',country='';
  String linkedIn='',portfolio='',github='',summary='';
  final List<EducationEntry> education=[];
  final List<ExperienceEntry> experience=[];
  final List<ProjectEntry> projects=[];
  final List<CertificationEntry> certifications=[];
  final List<String> skills=[];
  final List<String> languages=[];

  Map<String,dynamic> toJson()=>{'id':id,'fullName':fullName,'jobTitle':jobTitle,'phone':phone,'email':email,'city':city,'state':state,'country':country,'linkedIn':linkedIn,'portfolio':portfolio,'github':github,'summary':summary,'education':education.map((e)=>e.toJson()).toList(),'experience':experience.map((e)=>e.toJson()).toList(),'projects':projects.map((e)=>e.toJson()).toList(),'certifications':certifications.map((e)=>e.toJson()).toList(),'skills':skills,'languages':languages};
  factory ResumeData.fromJson(Map<String,dynamic> j){
    final r=ResumeData(id:j['id']?.toString());
    r.fullName=j['fullName']??'';r.jobTitle=j['jobTitle']??'';r.phone=j['phone']??'';r.email=j['email']??'';
    r.city=j['city']??'';r.state=j['state']??'';r.country=j['country']??'';r.linkedIn=j['linkedIn']??'';r.portfolio=j['portfolio']??'';r.github=j['github']??'';r.summary=j['summary']??'';
    r.education.addAll((j['education'] as List? ?? []).map((e)=>EducationEntry.fromJson(Map<String,dynamic>.from(e))));
    r.experience.addAll((j['experience'] as List? ?? []).map((e)=>ExperienceEntry.fromJson(Map<String,dynamic>.from(e))));
    r.projects.addAll((j['projects'] as List? ?? []).map((e)=>ProjectEntry.fromJson(Map<String,dynamic>.from(e))));
    r.certifications.addAll((j['certifications'] as List? ?? []).map((e)=>CertificationEntry.fromJson(Map<String,dynamic>.from(e))));
    r.skills.addAll(List<String>.from(j['skills']??[]));r.languages.addAll(List<String>.from(j['languages']??[]));return r;
  }
  String encode()=>jsonEncode(toJson());
  factory ResumeData.decode(String s)=>ResumeData.fromJson(jsonDecode(s));
}
