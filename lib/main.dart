// File: cv_comment/lib/main.dart
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const CommentApp());
}

class CommentApp extends StatelessWidget {
  const CommentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تعليقات المستخدمين',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CommentPage(),
    );
  }
}

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<String> _comments = [];

  @override
  void initState() {
    super.initState();

    // 1) تحميل التعليقات المحفوظة سابقاً من localStorage
    final saved = html.window.localStorage['comments'];
    if (saved != null) {
      try {
        _comments = List<String>.from(json.decode(saved));
      } catch (_) {
        _comments = [];
      }
    }

    // 2) الاستماع لأي رسالة واردة عبر window.postMessage
    html.window.onMessage.listen((event) {
      if (event.data is String && (event.origin == html.window.origin || event.origin == '*')) {
        setState(() {
          // نضيف أحدث تعليق في الأعلى
          _comments.insert(0, event.data as String);
        });
        // ثم نحفظ القائمة مجدداً
        html.window.localStorage['comments'] = json.encode(_comments);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعليقات المستخدمين'),
        centerTitle: true,
      ),
      body: _comments.isEmpty
          ? const Center(child: Text('لا توجد تعليقات بعد'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _comments.length,
        itemBuilder: (context, i) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(_comments[i]),
            ),
          );
        },
      ),
    );
  }
}
