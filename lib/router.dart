// import 'package:appwrite/appwrite.dart';
// import 'package:go_router/go_router.dart';
// import 'package:notes_tasks/login/login_screen.dart';
// import 'package:notes_tasks/notes/notes_screen.dart';

// // GoRouter configuration
// class Router extends GoRouter {
//   Router._internal({required Account account})
//       : super(
//           // TODO: Somehow store user token in `shared_preferences` and skip login screen
//           initialLocation: '/',
//           routes: [
//             GoRoute(
//               path: '/',
//               builder: (context, state) => LoginScreen(account: account),
//             ),
//             GoRoute(
//               path: '/notes',
//               builder: (context, state) => NotesScreen(),
//             ),
//           ],
//         );

//   static Router? _instance;

//   factory Router({required Account account}) {
//     _instance ??= Router._internal({account: account});
//     return _instance;
//   }
// }
