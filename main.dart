import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MarioIAApp());
}

class MarioIAApp extends StatelessWidget {
  const MarioIAApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'María-IA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final MarioIA _ia = MarioIA();

  @override
  void initState() {
    super.initState();
    _addMessage('¡Hola! Soy María-IA. ¿Cómo puedo ayudarte? 😊', isUser: false);
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    String userText = _controller.text;
    _addMessage(userText, isUser: true);

    String respons
