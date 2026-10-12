import 'package:flutter/material.dart';
import '../../models/resume_data.dart';
import 'resume_preview_screen.dart';

class ResumeSectionsScreen extends StatefulWidget {
  const ResumeSectionsScreen({super.key,required this.data});
  final ResumeData data;
  @override State<ResumeSectionsScreen> createState()=>_ResumeSectionsScreenState();
}
class _ResumeSectionsScreenState extends State<ResumeSectionsScreen>{
  final summary=TextEditingController(),skill=TextEditingController(),language=TextEditingController();

  void sheet(String title,List<String> labels,ValueChanged<List<String>> save)=>showModalBottomSheet(
    context:context,isScrollControlled:true,builder:(_)=>_EntrySheet(title:title,labels:labels,onSave:(v){save(v);setState((){});}));

  void addEducation()=>sheet('Add Education',['Degree / Course','School / College','Passing Year','Percentage / CGPA'],(v)=>
    widget.data.education.add(EducationEntry(degree:v[0],institute:v[1],year:v[2],score:v[3])));
  void addExperience()=>sheet('Add Experience',['Job Title','Company','Duration','Responsibilities / Achievements'],(v)=>
    widget.data.experience.add(ExperienceEntry(role:v[0],company:v[1],duration:v[2],description:v[3])));
  void addProject()=>sheet('Add Project',['Project Name','Description','Project Link'],(v)=>
    widget.data.projects.add(ProjectEntry(name:v[0],description:v[1],link:v[2])));
  void addCertification()=>sheet('Add Certification',['Certification Name','Issuer / Organization','Year'],(v)=>
    widget.data.certifications.add(CertificationEntry(name:v[0],issuer:v[1],year:v[2])));

  void addList(TextEditingController c,List<String> list){final v=c.text.trim();if(v.isNotEmpty){setState(()=>list.add(v));c.clear();}}

  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Build Resume')),
    body:ListView(padding:const EdgeInsets.all(20),children:[
      Text('Complete your resume',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),
      const SizedBox(height:18),
      TextField(controller:summary,maxLines:4,onChanged:(v)=>widget.data.summary=v,
        decoration:const InputDecoration(labelText:'Professional Summary / Career Objective',
          hintText:'Write 2–4 lines about your strengths, experience and career goal.')),
      const SizedBox(height:14),
      _SectionCard(title:'Education',icon:Icons.school_outlined,count:widget.data.education.length,onAdd:addEducation),
      _SectionCard(title:'Experience',icon:Icons.work_outline,count:widget.data.experience.length,onAdd:addExperience),
      _SectionCard(title:'Projects',icon:Icons.folder_outlined,count:widget.data.projects.length,onAdd:addProject),
      _SectionCard(title:'Certifications',icon:Icons.workspace_premium_outlined,count:widget.data.certifications.length,onAdd:addCertification),
      _TagCard(title:'Skills',hint:'e.g. Excel, Flutter, Tally Prime',controller:skill,items:widget.data.skills,
        onAdd:()=>addList(skill,widget.data.skills),onDelete:(x)=>setState(()=>widget.data.skills.remove(x))),
      _TagCard(title:'Languages',hint:'e.g. Bengali, English, Hindi',controller:language,items:widget.data.languages,
        onAdd:()=>addList(language,widget.data.languages),onDelete:(x)=>setState(()=>widget.data.languages.remove(x))),
      const SizedBox(height:18),
      FilledButton.icon(onPressed:(){
        widget.data.summary=summary.text.trim();
        Navigator.push(context,MaterialPageRoute(builder:(_)=>ResumePreviewScreen(data:widget.data)));
      },icon:const Icon(Icons.visibility_outlined),label:const Text('Preview Resume')),
    ]));

}
class _SectionCard extends StatelessWidget{
  const _SectionCard({required this.title,required this.icon,required this.count,required this.onAdd});
  final String title;final IconData icon;final int count;final VoidCallback onAdd;
  @override Widget build(BuildContext context)=>Card(child:ListTile(leading:Icon(icon),title:Text(title,style:const TextStyle(fontWeight:FontWeight.w600)),
    subtitle:Text(count==0?'Nothing added yet':'$count item(s) added'),trailing:IconButton.filledTonal(onPressed:onAdd,icon:const Icon(Icons.add))));
}
class _TagCard extends StatelessWidget{
  const _TagCard({required this.title,required this.hint,required this.controller,required this.items,required this.onAdd,required this.onDelete});
  final String title,hint;final TextEditingController controller;final List<String> items;final VoidCallback onAdd;final ValueChanged<String> onDelete;
  @override Widget build(BuildContext context)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(title,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:10),
    Row(children:[Expanded(child:TextField(controller:controller,decoration:InputDecoration(hintText:hint))),const SizedBox(width:8),
      IconButton.filled(onPressed:onAdd,icon:const Icon(Icons.add))]),
    if(items.isNotEmpty) Padding(padding:const EdgeInsets.only(top:10),child:Wrap(spacing:8,children:items.map((x)=>Chip(label:Text(x),onDeleted:()=>onDelete(x))).toList()))
  ])));
}
class _EntrySheet extends StatefulWidget{
  const _EntrySheet({required this.title,required this.labels,required this.onSave});
  final String title;final List<String> labels;final ValueChanged<List<String>> onSave;
  @override State<_EntrySheet> createState()=>_EntrySheetState();
}
class _EntrySheetState extends State<_EntrySheet>{
  late final controllers=widget.labels.map((_)=>TextEditingController()).toList();
  @override Widget build(BuildContext context)=>Padding(padding:EdgeInsets.fromLTRB(20,20,20,20+MediaQuery.of(context).viewInsets.bottom),
    child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.stretch,children:[
      Text(widget.title,style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),const SizedBox(height:16),
      for(int i=0;i<widget.labels.length;i++) Padding(padding:const EdgeInsets.only(bottom:12),child:TextField(
        controller:controllers[i],maxLines:i==widget.labels.length-1&&widget.labels.length==4?3:1,decoration:InputDecoration(labelText:widget.labels[i]))),
      FilledButton(onPressed:(){widget.onSave(controllers.map((e)=>e.text.trim()).toList());Navigator.pop(context);},child:const Text('Save'))
    ])));
}
