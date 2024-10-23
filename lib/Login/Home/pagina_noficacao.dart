import 'package:flutter/material.dart';

class PaginaNotificacao extends StatelessWidget {
  final String? dado;

  const PaginaNotificacao({super.key, this.dado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página da Notificação'),
      ),
      body: Center(
        child: Text('Dados recebidos: $dado'),
      ),
    );
  }
}
