import 'package:flutter/material.dart';
import '../../models/resume_data.dart';
import '../../services/resume_storage.dart';
import '../resume/personal_details_screen.dart';
import '../resume/resume_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  List<ResumeData> resumes=[]; bool loading=true;
  @override void initState(){super.initState();_load();}
  Future<void> _load() async {final r=await ResumeStorage.load();if(mounted)setState((){resumes=r;loading=false;});}
  Future<void> _delete(ResumeData r) async {await ResumeStorage.delete(r.id);await _load();}
  Future<void> _openCreate() async {await Navigator.push(context,MaterialPageRoute(builder:(_)=>const PersonalDetailsScreen()));await _load();}
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Smart Resume')),
    floatingActionButton:FloatingActionButton.extended(onPressed:_openCreate,icon:const Icon(Icons.add),label:const Text('New Resume')),
    body:loading?const Center(child:CircularProgressIndicator()):ListView(padding:const EdgeInsets.all(20),children:[
      Text('Your resumes',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.bold)),
      const SizedBox(height:6),const Text('Offline, ATS-friendly and private.'),const SizedBox(height:20),
      if(resumes.isEmpty) Card(child:Padding(padding:const EdgeInsets.all(24),child:Column(children:[
        const Icon(Icons.description_outlined,size:54),const SizedBox(height:12),const Text('No saved resume yet',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),
        const SizedBox(height:12),FilledButton.icon(onPressed:_openCreate,icon:const Icon(Icons.add),label:const Text('Create Resume'))
      ]))),
      ...resumes.map((r)=>Card(child:ListTile(
        leading:const CircleAvatar(child:Icon(Icons.description_outlined)),
        title:Text(r.fullName.isEmpty?'Untitled Resume':r.fullName),subtitle:Text(r.jobTitle.isEmpty?'Resume':r.jobTitle),
        onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ResumePreviewScreen(data:r))).then((_)=>_load()),
        trailing:PopupMenuButton<String>(onSelected:(v)async{
          if(v=='edit'){await Navigator.push(context,MaterialPageRoute(builder:(_)=>PersonalDetailsScreen(existing:r)));await _load();}
          if(v=='delete'){await _delete(r);}
        },itemBuilder:(_)=>const [PopupMenuItem(value:'edit',child:Text('Edit')),PopupMenuItem(value:'delete',child:Text('Delete'))])
      )))
    ]));
}
