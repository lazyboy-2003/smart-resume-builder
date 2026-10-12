import 'package:flutter/material.dart';
import '../../models/resume_data.dart';

class ResumePreviewScreen extends StatelessWidget {
  const ResumePreviewScreen({super.key,required this.data});
  final ResumeData data;

  Widget heading(String text)=>Padding(
    padding:const EdgeInsets.only(top:18,bottom:6),
    child:Text(text.toUpperCase(),style:const TextStyle(fontSize:12,fontWeight:FontWeight.w800,letterSpacing:1.2)));

  @override Widget build(BuildContext context){
    final location=[data.city,data.state,data.country].where((e)=>e.isNotEmpty).join(', ');
    return Scaffold(
      appBar:AppBar(title:const Text('Resume Preview')),
      body:Container(color:Colors.grey.shade200,child:ListView(padding:const EdgeInsets.all(16),children:[
        Container(
          padding:const EdgeInsets.all(28),color:Colors.white,
          child:DefaultTextStyle(style:const TextStyle(color:Colors.black87,fontSize:13,height:1.35),child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(data.fullName,style:const TextStyle(fontSize:28,fontWeight:FontWeight.w800)),
              Text(data.jobTitle,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w500)),
              const SizedBox(height:8),
              Text([data.phone,data.email,location].where((e)=>e.isNotEmpty).join('  •  ')),
              if(data.linkedIn.isNotEmpty||data.portfolio.isNotEmpty||data.github.isNotEmpty)
                Text([data.linkedIn,data.portfolio,data.github].where((e)=>e.isNotEmpty).join('  •  ')),
              if(data.summary.isNotEmpty)...[heading('Professional Summary'),Text(data.summary)],
              if(data.skills.isNotEmpty)...[heading('Key Skills'),Text(data.skills.join(' • '))],
              if(data.experience.isNotEmpty)...[
                heading('Experience'),
                ...data.experience.map((e)=>Padding(padding:const EdgeInsets.only(bottom:10),child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,children:[
                    Text(e.role,style:const TextStyle(fontWeight:FontWeight.bold)),
                    Text([e.company,e.duration].where((x)=>x.isNotEmpty).join(' | ')),
                    if(e.description.isNotEmpty) Text(e.description),
                  ])))
              ],
              if(data.education.isNotEmpty)...[
                heading('Education'),
                ...data.education.map((e)=>Padding(padding:const EdgeInsets.only(bottom:8),child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,children:[
                    Text(e.degree,style:const TextStyle(fontWeight:FontWeight.bold)),
                    Text([e.institute,e.year,e.score].where((x)=>x.isNotEmpty).join(' | ')),
                  ])))
              ],
              if(data.projects.isNotEmpty)...[
                heading('Projects'),
                ...data.projects.map((e)=>Padding(padding:const EdgeInsets.only(bottom:8),child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,children:[
                    Text(e.name,style:const TextStyle(fontWeight:FontWeight.bold)),
                    if(e.description.isNotEmpty) Text(e.description),
                    if(e.link.isNotEmpty) Text(e.link),
                  ])))
              ],
              if(data.certifications.isNotEmpty)...[
                heading('Certifications'),
                ...data.certifications.map((e)=>Text([e.name,e.issuer,e.year].where((x)=>x.isNotEmpty).join(' | ')))
              ],
              if(data.languages.isNotEmpty)...[heading('Languages'),Text(data.languages.join(' • '))],
            ])),
        )
      ])),
    );
  }
}
