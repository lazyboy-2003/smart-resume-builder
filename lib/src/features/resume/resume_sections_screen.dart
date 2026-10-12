import 'package:flutter/material.dart';
import '../../models/resume_data.dart';

class ResumeSectionsScreen extends StatefulWidget {
  const ResumeSectionsScreen({super.key, required this.data});
  final ResumeData data;

  @override
  State<ResumeSectionsScreen> createState() => _ResumeSectionsScreenState();
}

class _ResumeSectionsScreenState extends State<ResumeSectionsScreen> {
  final skillController = TextEditingController();

  void addEducation() {
    final item = EducationEntry();
    widget.data.education.add(item);
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      builder: (_) => _EntrySheet(
        title: 'Add Education',
        labels: const ['Degree / Course', 'School / College', 'Passing Year', 'Percentage / CGPA'],
        onSave: (v) { item.degree=v[0]; item.institute=v[1]; item.year=v[2]; item.score=v[3]; setState(() {}); },
      ),
    );
  }

  void addExperience() {
    final item = ExperienceEntry();
    widget.data.experience.add(item);
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      builder: (_) => _EntrySheet(
        title: 'Add Experience',
        labels: const ['Job Title', 'Company', 'Duration', 'Responsibilities / Achievements'],
        onSave: (v) { item.role=v[0]; item.company=v[1]; item.duration=v[2]; item.description=v[3]; setState(() {}); },
      ),
    );
  }

  void addProject() {
    final item = ProjectEntry();
    widget.data.projects.add(item);
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      builder: (_) => _EntrySheet(
        title: 'Add Project',
        labels: const ['Project Name', 'Description', 'Project Link'],
        onSave: (v) { item.name=v[0]; item.description=v[1]; item.link=v[2]; setState(() {}); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Build Resume')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Complete your resume', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _SectionCard(title:'Education', icon:Icons.school_outlined, count:widget.data.education.length, onAdd:addEducation),
        _SectionCard(title:'Experience', icon:Icons.work_outline, count:widget.data.experience.length, onAdd:addExperience),
        _SectionCard(title:'Projects', icon:Icons.folder_outlined, count:widget.data.projects.length, onAdd:addProject),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          const Text('Skills', style: TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          const SizedBox(height:12),
          Row(children:[
            Expanded(child:TextField(controller:skillController, decoration:const InputDecoration(hintText:'e.g. Excel, Flutter, Tally Prime'))),
            const SizedBox(width:8),
            IconButton.filled(onPressed:(){
              final s=skillController.text.trim();
              if(s.isNotEmpty){setState(()=>widget.data.skills.add(s)); skillController.clear();}
            }, icon:const Icon(Icons.add))
          ]),
          if(widget.data.skills.isNotEmpty) Padding(
            padding:const EdgeInsets.only(top:12),
            child:Wrap(spacing:8, children:widget.data.skills.map((s)=>Chip(
              label:Text(s), onDeleted:()=>setState(()=>widget.data.skills.remove(s)))).toList()))
        ]))),
        const SizedBox(height:20),
        FilledButton.icon(onPressed:(){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Resume draft saved in this session')));
        }, icon:const Icon(Icons.save_outlined), label:const Text('Save Resume Draft')),
      ]),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title,required this.icon,required this.count,required this.onAdd});
  final String title; final IconData icon; final int count; final VoidCallback onAdd;
  @override Widget build(BuildContext context)=>Card(child:ListTile(
    leading:Icon(icon), title:Text(title,style:const TextStyle(fontWeight:FontWeight.w600)),
    subtitle:Text(count==0?'Nothing added yet':'$count item(s) added'),
    trailing:IconButton.filledTonal(onPressed:onAdd,icon:const Icon(Icons.add))));
}

class _EntrySheet extends StatefulWidget {
  const _EntrySheet({required this.title,required this.labels,required this.onSave});
  final String title; final List<String> labels; final ValueChanged<List<String>> onSave;
  @override State<_EntrySheet> createState()=>_EntrySheetState();
}
class _EntrySheetState extends State<_EntrySheet>{
  late final List<TextEditingController> controllers=widget.labels.map((_)=>TextEditingController()).toList();
  @override Widget build(BuildContext context)=>Padding(
    padding:EdgeInsets.fromLTRB(20,20,20,20+MediaQuery.of(context).viewInsets.bottom),
    child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.stretch,children:[
      Text(widget.title,style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),
      const SizedBox(height:16),
      for(int i=0;i<widget.labels.length;i++) Padding(padding:const EdgeInsets.only(bottom:12),
        child:TextField(controller:controllers[i],maxLines:i==widget.labels.length-1&&widget.labels.length==4?3:1,
          decoration:InputDecoration(labelText:widget.labels[i]))),
      FilledButton(onPressed:(){widget.onSave(controllers.map((e)=>e.text.trim()).toList());Navigator.pop(context);},child:const Text('Save'))
    ])));
}
