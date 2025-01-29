import 'package:go_router/go_router.dart';
import 'package:llamapp/view/page/chat.dart';
import 'package:llamapp/view/page/nav.dart';

final appRouter = GoRouter(initialLocation: "/chat", routes: [
  GoRoute(
    path: '/chat',
    builder: (context, state) {
      return AppNavigatorPage(child: ChatPage());
    },
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) {
      return AppNavigatorPage(child: ChatPage());
    },
  )
]);
