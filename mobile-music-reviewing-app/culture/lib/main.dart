import 'package:culture/presentation/scaffolds/AlbumListReviewScaffold.dart';
import 'package:culture/presentation/scaffolds/AlbumSearchScaffold.dart';
import 'package:culture/presentation/scaffolds/GenreAndDetailedGenreScaffold.dart';
import 'package:culture/presentation/scaffolds/HubGenreScaffold.dart';
import 'package:culture/presentation/scaffolds/ListAndAlbumScaffold.dart';
import 'package:culture/presentation/scaffolds/ListScaffold.dart';
import 'package:culture/presentation/scaffolds/LoginScaffold.dart';
import 'package:culture/presentation/scaffolds/SignUpPageScaffold.dart';
import 'package:culture/presentation/scaffolds/UserProfileScaffold.dart';
import 'package:culture/presentation/scaffolds/VarStarAlbumReviewScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

final GoRouter _router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return '/loginpage';
    } else {
      return null;
    }
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HubGenreScaffold();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'genreselectionscaffold',
          builder: (BuildContext context, GoRouterState state) {
            return const HubGenreScaffold();
          },
        ),
        GoRoute(
          path: 'userprofilescaffold/:number',
          builder: (BuildContext context, GoRouterState state) {
            return UserProfileScaffold(
              starCount: state.pathParameters['number'],
            );
          },
        ),
        GoRoute(
          path: 'listselectedlist',
          builder: (BuildContext context, GoRouterState state) {
            return const ListAndSelectedListScaffold();
          },
        ),
        GoRoute(
          path: 'selectedlistalbum',
          builder: (BuildContext context, GoRouterState state) {
            return ListAndAlbumScaffold();
          },
        ),
        GoRoute(
          path: 'genredetailedgenre/:genreName',
          builder: (BuildContext context, GoRouterState state) {
            return GenreAndDetailedGenreSelectionScaffold(
              genreName: state.pathParameters['genreName'],
            );
          },
        ),
        GoRoute(
          name: 'detailedgenrereview',
          path: 'detailedgenrereview',
          builder: (BuildContext context, GoRouterState state) {
            return AlbumListReviewScaffold(
              albumName: state.queryParameters['albumName'],
              artistName: state.queryParameters['artistName'],
            );
          },
        ),
        GoRoute(
          path: 'albumsearchscaffold',
          builder: (BuildContext context, GoRouterState state) {
            return const AlbumSearchScaffold(genreName: 'jazz');
          },
        ),
        GoRoute(
            path: 'loginpage',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPageScaffold();
            }),
        GoRoute(
            path: 'signuppage',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpPageScaffold();
            }),
        GoRoute(
            path: 'varstarreview/:number',
            name: 'varstarreview',
            builder: (BuildContext context, GoRouterState state) {
              return VarStarReviewScaffold(
                starCount: state.pathParameters['starCount'],
                albumName: state.queryParameters['albumName'],
                artistName: state.queryParameters['artistName'],
              );
            }),
      ],
    ),
  ],
);

class MainApp extends ConsumerStatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //https://pub.dev/packages/flutter_adaptive_scaffold
      routerConfig: _router,
      title: "Culture",
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
