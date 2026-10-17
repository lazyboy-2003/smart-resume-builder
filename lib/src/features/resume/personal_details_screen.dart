import 'package:flutter/material.dart';
import '../../models/resume_data.dart';
import 'resume_sections_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key,this.existing});
  final ResumeData? existing;
  @override State<PersonalDetailsScreen> createState()=>_PersonalDetailsScreenState();
}
class _PersonalDetailsScreenState extends State<PersonalDetailsScreen>{
  final formKey=GlobalKey<FormState>(); late final ResumeData data;
  late final Map<String,TextEditingController> c;
  @override void initState(){super.initState();data=widget.existing??ResumeData();c={
    'name':TextEditingController(text:data.fullName),'title':TextEditingController(text:data.jobTitle),'phone':TextEditingController(text:data.phone),
    'email':TextEditingController(text:data.email),'city':TextEditingController(text:data.city),'state':TextEditingController(text:data.state),
    'country':TextEditingController(text:data.country),'linkedin':TextEditingController(text:data.linkedIn),'portfolio':TextEditingController(text:data.portfolio),'github':TextEditingController(text:data.github)};}
  Widget field(String key,String label,{bool required=false,TextInputType? type})=>Padding(padding:const EdgeInsets.only(bottom:14),child:TextFormField(controller:c[key],keyboardType:type,decoration:InputDecoration(labelText:label),validator:required?(v)=>v==null||v.trim().isEmpty?'Required':null));
  void next(){if(!formKey.currentState!.validate())return;data.fullName=c['name']!.text.trim();data.jobTitle=c['title']!.text.trim();data.phone=c['phone']!.text.trim();data.email=c['email']!.text.trim();data.city=c['city']!.text.trim();data.state=c['state']!.text.trim();data.country=c['country']!.text.trim();data.linkedIn=c['linkedin']!.text.trim();data.portfolio=c['portfolio']!.text.trim();data.github=c['github']!.text.trim();Navigator.push(context,MaterialPageRoute(builder:(_)=>ResumeSectionsScreen(data:data)));}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(widget.existing==null?'Personal Details':'Edit Personal Details')),body:Form(key:formKey,child:ListView(padding:const EdgeInsets.all(20),children:[
    Text('Tell us about you',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),const SizedBox(height:20),
    field('name','Full Name',required:true),field('title','Professional Title / Job Role',required:true),field('phone','Mobile Number',required:true,type:TextInputType.phone),
    field('email','Email Address',required:true,type:TextInputType.emailAddress),field('city','City'),field('state','State'),field('country','Country'),
    const SizedBox(height:8),Text('Professional Links',style:Theme.of(context).textTheme.titleMedium),const SizedBox(height:12),
    field('linkedin','LinkedIn'),field('portfolio','Portfolio / Website'),field('github','GitHub'),const SizedBox(height:18),
    FilledButton(onPressed:next,child:const Text('Save & Continue'))
  ])));
}
