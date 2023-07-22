import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../provider/LoadProvider.dart';

Future<Database> _openDatabase() async {
  final String databasesPath = await getDatabasesPath();
  final String path = join(databasesPath, 'my_app.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            name TEXT
          )
        ''');
    },
  );
}
Future<void> saveUserDataLocally(String email, String name) async {
  final Database db = await _openDatabase();
  await db.insert(
    'users',
    {'email': email, 'name': name},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<String> getEmailFromLocalDatabase() async {
  final Database db = await _openDatabase();
  final List<Map<String, dynamic>> rows = await db.query('users');
  if (rows.isNotEmpty) {
    final user = rows.first;
    return user['email'];
  } else {
    return '';
  }
}

Future<void> checkEmailFromLocalDatabase(BuildContext context) async {
  final provider = Provider.of<LoadProvider>(context, listen: false);
  final Database db = await _openDatabase();
  final List<Map<String, dynamic>> rows = await db.query('users');
  if (rows.isNotEmpty) {
    provider.state=1;
  } else {
    provider.state=0;
  }
}

Future<String> getNameFromLocalDatabase() async {
  final Database db = await _openDatabase();
  final List<Map<String, dynamic>> rows = await db.query('users');
  if (rows.isNotEmpty) {
    final user = rows.first;
    return user['name'];
  } else {
    return '';
  }
}
Future<void> removeUserDataLocally() async {
  final Database db = await _openDatabase();
  await db.delete('users');
}

Future<void> updateUserDataLocally(String newEmail, String newName) async {
  final Database db = await _openDatabase();
  await db.update(
    'users',
    {'email': newEmail, 'name': newName},
  );
}