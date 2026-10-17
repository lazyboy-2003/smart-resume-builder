import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../models/resume_data.dart';
import '../../services/resume_storage.dart';

class ResumePreviewScreen extends StatelessWidget {
  const ResumePreviewScreen({super.key,required this.data});
  final ResumeData data;
  Widget heading(String text)=>Padding(padding:const EdgeInsets.only(top:18,bottom:6),child:Text(text.toUpperCase(),style:const TextStyle(fontSize:12,fontWeight:FontWeight.w800,letterSpacing:1.2)));
  Future<void> exportPdf() async {
    final doc=pw.Document(); final location=[data.city,data.state,data.country].where((e)=>e.isNotEmpty).join(', ');
    pw.Widget h(String s)=>pw.Padding(padding:const pw.EdgeInsets.only(top:12,bottom:4),child:pw.Text(s.toUpperCase(),style:pw.TextStyle(fontSize:10,fontWeight:pw.FontWeight.bold)));
    doc.addPage(pw.MultiPage(pageFormat:PdfPageFormat.a4,margin:const pw.EdgeInsets.all(36),build:(_)=>[
      pw.Text(data.fullName,style:pw.TextStyle(fontSize:24,fontWeight:pw.FontWeight.bold)),pw.Text(data.jobTitle),pw.SizedBox(height:5),
      pw.Text([data.phone,data.email,location].where((e)=>e.isNotEmpty).join(' | ')),
      if(data.summary.isNotEmpty)...[h('Professional Summary'),pw.Text(data.summary)],
      if(data.skills.isNotEmpty)...[h('Key Skills'),pw.Text(data.skills.join(', '))],
      if(data.experience.isNotEmpty)...[h('Experience'),...data.experience.expand((e)=>[pw.Text(e.role,style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),pw.Text([e.company,e.duration].where((x)=>x.isNotEmpty).join(' | ')),if(e.description.isNotEmpty)pw.Text(e.description),pw.SizedBox(height:6)])],
      if(data.education.isNotEmpty)...[h('Education'),...data.education.expand((e)=>[pw.Text(e.degree,style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),pw.Text([e.institute,e.year,e.score].where((x)=>x.isNotEmpty).join(' | ')),pw.SizedBox(height:5)])],
      if(data.projects.isNotEmpty)...[h('Projects'),...data.projects.expand((e)=>[pw.Text(e.name,style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),if(e.description.isNotEmpty)pw.Text(e.description),if(e.link.isNotEmpty)pw.Text(e.link),pw.SizedBox(height:5)])],
      if(data.certifications.isNotEmpty)...[h('Certifications'),...data.certifications.map((e)=>pw.Text([e.name,e.issuer,e.year].where((x)=>x.isNotEmpty).join(' | ')))],
      if(data.languages.isNotEmpty)...[h('Languages'),pw.Text(data.languages.join(', '))]
    ]));
    await Printing.layoutPdf(onLayout:(_)=>doc.save(),name:'resume.pdf');
  }
  @override Widget build(BuildContext context){
    final location=[data.city,data.state,data.country].where((e)=>e.isNotEmpty).join(', ');
    return Scaffold(appBar:AppBar(title:const Text('Resume Preview'),actions:[
      IconButton(tooltip:'Save',onPressed:()async{await ResumeStorage.save(data);if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Resume saved offline')));},icon:const Icon(Icons.save_outlined)),
      IconButton(tooltip:'Export PDF',onPressed:exportPdf,icon:const Icon(Icons.picture_as_pdf_outlined))
    ]),body:Container(color:Colors.grey.shade200,child:ListView(padding:const EdgeInsets.all(16),children:[Container(padding:const EdgeInsets.all(28),color:Colors.white,child:DefaultTextStyle(style:const TextStyle(color:Colors.black87,fontSize:13,height:1.35),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(data.fullName,style:const TextStyle(fontSize:28,fontWeight:FontWeight.w800)),Text(data.jobTitle,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w500)),const SizedBox(height:8),
      Text([data.phone,data.email,location].where((e)=>e.isNotEmpty).join(' • ')),
      if(data.summary.isNotEmpty)...[heading('Professional Summary'),Text(data.summary)],if(data.skills.isNotEmpty)...[heading('Key Skills'),Text(data.skills.join(' • '))],
      if(data.experience.isNotEmpty)...[heading('Experience'),...data.experience.map((e)=>Padding(padding:const EdgeInsets.only(bottom:10),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(e.role,style:const TextStyle(fontWeight:FontWeight.bold)),Text([e.company,e.duration].where((x)=>x.isNotEmpty).join(' | ')),if(e.description.isNotEmpty)Text(e.description)])))],
      if(data.education.isNotEmpty)...[heading('Education'),...data.education.map((e)=>Padding(padding:const EdgeInsets.only(bottom:8),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(e.degree,style:const TextStyle(fontWeight:FontWeight.bold)),Text([e.institute,e.year,e.score].where((x)=>x.isNotEmpty).join(' | '))])))],
      if(data.projects.isNotEmpty)...[heading('Projects'),...data.projects.map((e)=>Padding(padding:const EdgeInsets.only(bottom:8),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(e.name,style:const TextStyle(fontWeight:FontWeight.bold)),if(e.description.isNotEmpty)Text(e.description),if(e.link.isNotEmpty)Text(e.link)])))],
      if(data.certifications.isNotEmpty)...[heading('Certifications'),...data.certifications.map((e)=>Text([e.name,e.issuer,e.year].where((x)=>x.isNotEmpty).join(' | ')))],
      if(data.languages.isNotEmpty)...[heading('Languages'),Text(data.languages.join(' • '))]
    ])))])));
  }
}
