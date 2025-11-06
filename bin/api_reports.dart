import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  final reports = [
    {
      'user': 'Ana García',
      'location': 'Centro de la ciudad',
      'image': '🌆',
      'description': 'Problema con el alumbrado público en la calle principal',
      'time': 'Hace 2 horas',
    },
    {
      'user': 'Carlos Mendoza',
      'location': 'Parque Central',
      'image': '🌳',
      'description': 'Basura acumulada en los contenedores del parque',
      'time': 'Hace 4 horas',
    },
    {
      'user': 'María López',
      'location': 'Avenida Principal',
      'image': '🚧',
      'description': 'Bache grande que necesita reparación urgente',
      'time': 'Hace 6 horas',
    },
    {
      'user': 'José Ramírez',
      'location': 'Plaza de Armas',
      'image': '🚦',
      'description': 'Semáforo descompuesto causando tráfico',
      'time': 'Hace 8 horas',
    },
  ];

  final users = [
    {"name": "Angel", "age": 35, "phone": "6122308184"},
    {"name": "Vale", "age": 21, "phone": "6122887967"}
  ];

  // Endpoints
  router.get('/hello', (Request request) {
    return Response.ok('Hola Mundo');
  });

  router.get('/reports', (Request request) {
    return Response.ok(jsonEncode(reports),
        headers: {'Content-Type': 'application/json'});
  });

  router.get('/users', (Request request) {
    return Response.ok(jsonEncode(users),
        headers: {'Content-Type': 'application/json'});
  });

  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(router);

  await io.serve(handler, 'localhost', 8080);
  print('Servidor corriendo en el puerto 8080');
}

