import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/resume_data.dart';

class ResumeStorage {
  static const _key='saved_resumes_v1';
  static Future<List<ResumeData>> load() async {
    final p=await SharedPreferences.getInstance();
    return (p.getStringList(_key)??[]).map(ResumeData.decode).toList();
  }
  static Future<void> save(ResumeData data) async {
    final p=await SharedPreferences.getInstance();
    final list=await load();
    final i=list.indexWhere((e)=>e.id==data.id);
    if(i<0){list.insert(0,data);}else{list[i]=data;}
    await p.setStringList(_key,list.map((e)=>e.encode()).toList());
  }
  static Future<void> delete(String id) async {
    final p=await SharedPreferences.getInstance();
    final list=await load()..removeWhere((e)=>e.id==id);
    await p.setStringList(_key,list.map((e)=>jsonEncode(e.toJson())).toList());
  }
}
