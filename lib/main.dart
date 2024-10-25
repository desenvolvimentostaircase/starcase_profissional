import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:profissional/Login/Home/home_page.dart';
import 'package:profissional/Login/Home/pagina_noficacao.dart';
import 'package:profissional/checagem_page.dart';
import 'package:profissional/firebase_options.dart';
import 'package:profissional/servicos/firebase_messaging_service.dart';
import 'package:profissional/servicos/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializa os serviços de notificação
  final NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  final FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initialize();

  // Solicita permissão para enviar notificações
  await requestPermission();

  runApp(const MyApp());
}

// Função para solicitar permissão de notificações
Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Usuário concedeu permissão para notificações');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('Usuário concedeu permissão provisória');
  } else {
    print('Usuário negou a permissão');
  }

  // Obter o token do dispositivo
  String? token = await messaging.getToken();
  print("Token do dispositivo: $token");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 3, 68, 122)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ChecagemPage(),
        '/home': (context) => const HomePage(),
        '/paginaNotificacao': (context) => const PaginaNotificacao(),
      },
    );
  }
}
