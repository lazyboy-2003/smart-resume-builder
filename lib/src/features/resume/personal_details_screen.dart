import 'package:flutter/material.dart';
import '../../models/resume_data.dart';
import 'resume_sections_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});
  @override State<PersonalDetailsScreen> createState()=>_PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen>{
  final formKey=GlobalKey<FormState>();
  final data=ResumeData();
  bool optional=false;

  Widget field(String label, void Function(String) save,{bool required=false,TextInputType? type})=>
    Padding(padding:const EdgeInsets.only(bottom:14),child:TextFormField(
      keyboardType:type, decoration:InputDecoration(labelText:label),
      validator:required?(v)=>v==null||v.trim().isEmpty?'Required':null,
      onSaved:(v)=>save(v?.trim()??'')));

  void next(){
    if(!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    Navigator.push(context,MaterialPageRoute(builder:(_)=>ResumeSectionsScreen(data:data)));
  }

  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Personal Details')),
    body:Form(key:formKey,child:ListView(padding:const EdgeInsets.all(20),children:[
      Text('Tell us about you',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.bold)),
      const SizedBox(height:6),const Text('Only include information you want on your resume.'),const SizedBox(height:24),
      field('Full Name',(v)=>data.fullName=v,required:true),
      field('Professional Title / Job Role',(v)=>data.jobTitle=v,required:true),
      field('Mobile Number',(v)=>data.phone=v,required:true,type:TextInputType.phone),
      field('Email Address',(v)=>data.email=v,required:true,type:TextInputType.emailAddress),
      field('City',(v)=>data.city=v),field('State',(v)=>data.state=v),field('Country',(v)=>data.country=v),
      const SizedBox(height:8),Text('Professional Links',style:Theme.of(context).textTheme.titleMedium),const SizedBox(height:12),
      field('LinkedIn',(v)=>data.linkedIn=v),field('Portfolio / Website',(v)=>data.portfolio=v),field('GitHub',(v)=>data.github=v),
      SwitchListTile(contentPadding:EdgeInsets.zero,title:const Text('Add optional personal details'),
        subtitle:const Text('Enable only when the employer or CV format requires them.'),
        value:optional,onChanged:(v)=>setState(()=>optional=v)),
      if(optional)...[
        field('Full Address',(_){ }),field('PIN Code',(_){ },type:TextInputType.number),
        field('Date of Birth',(_){ }),field('Nationality',(_){ }),field('Marital Status',(_){ })],
      const SizedBox(height:20),FilledButton(onPressed:next,child:const Text('Save & Continue'))
    ])));
}
