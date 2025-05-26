import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mission.dart';

class MissionDatabase {
  static final MissionDatabase instance = MissionDatabase._init();
  static Database? _database;

  MissionDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('missions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE missions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        isCompleted INTEGER DEFAULT 0
      )
    ''');

    // JSON 파일에서 기본 미션 데이터 로드
    final String jsonString = await rootBundle.loadString('assets/data/missions.json');
    final MissionList missionList = MissionList.fromJson(json.decode(jsonString));
    
    // 배치 작업으로 데이터 삽입
    final batch = db.batch();
    for (final mission in missionList.missions) {
      batch.insert('missions', {'content': mission.content});
    }
    await batch.commit();
  }

  Future<String> getMission() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT content FROM missions ORDER BY RANDOM() LIMIT 1'
    );
    
    if (maps.isEmpty) {
      return '미션이 없습니다';
    }
    
    return maps.first['content'] as String;
  }
} 