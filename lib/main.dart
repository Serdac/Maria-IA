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

    String response = _ia.procesar(userText);
    Future.delayed(const Duration(milliseconds: 500), () {
      _addMessage(response, isUser: false);
    });

    _controller.clear();
  }

  void _addMessage(String text, {required bool isUser}) {
    setState(() {
      _messages.add(Message(text: text, isUser: isUser));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('María-IA 🤖'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text('Comienza la conversación...'),
                  )
                : ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[_messages.length - 1 - index];
                      return ChatBubble(message: message);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe algo...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

class MarioIA {
  final Map<String, List<String>> respuestas = {
    'hola': [
      '¡Hola! ¿Cómo estás? 👋',
      'Hola, es un placer verte',
      '¡Saludos! ¿En qué te puedo ayudar?',
    ],
    'nombre': [
      'Soy María-IA, tu asistente inteligente 🤖',
      'Me llamo María-IA',
    ],
    'ayuda': [
      'Puedo ayudarte con preguntas y conversación',
      'Dime qué necesitas y haré mi mejor esfuerzo',
    ],
    'adiós': [
      '¡Hasta luego! 👋',
      'Nos vemos pronto',
      '¡Que tengas un gran día!',
    ],
    'gracias': [
      'De nada, es un placer ayudarte 😊',
      'Para eso estamos',
    ],
  };

  final List<String> respuestasGenerales = [
    'Eso es interesante 🤔',
    'Entiendo, cuéntame más',
    'Hmm, buena pregunta',
    'Me gustaría saber más sobre eso',
    'Estoy aprendiendo de ti',
  ];

  String procesar(String texto) {
    String textoLower = texto.toLowerCase().trim();

    for (var entrada in respuestas.entries) {
      if (textoLower.contains(entrada.key)) {
        return _obtenerRespuestaAleatoria(entrada.value);
      }
    }

    return _obtenerRespuestaAleatoria(respuestasGenerales);
  }

  String _obtenerRespuestaAleatoria(List<String> lista) {
    return lista[Random().nextInt(lista.length)];
  }
}
