import 'package:central_jogos/pages/competition_details.dart';
import 'package:central_jogos/pages/competition_options.dart';
import 'package:central_jogos/pages/competitions.dart';
import 'package:central_jogos/pages/competitions2.dart';
import 'package:central_jogos/pages/competitions3.dart';
import 'package:central_jogos/pages/edit_competitions.dart';
import 'package:central_jogos/pages/explore.dart';
import 'package:central_jogos/pages/log_in.dart';
import 'package:central_jogos/pages/matches.dart';
import 'package:central_jogos/pages/my_subscriptions.dart';
import 'package:central_jogos/pages/notifications.dart';
import 'package:central_jogos/pages/players.dart';
import 'package:central_jogos/pages/profile.dart';
import 'package:central_jogos/pages/redefine_password.dart';
import 'package:central_jogos/pages/sing_up.dart';
import 'package:central_jogos/pages/splash_screen.dart';
import 'package:central_jogos/pages/subscribe.dart';
import 'package:central_jogos/pages/view_competitions.dart';
import 'package:flutter/material.dart';

class AppRoutes{
  static final Map<String, WidgetBuilder> routes = {
    "/" : (context) => const SplashScreen(),
    "/login" : (context) => const Login(),
    "/signup" : (context) => const SignUp(),
    "/redefine_password" : (context) => const RedefinePassword(),
    "/explore" : (context) => const Explore(),
    "/competition-subscribe" : (context) => const CompetitionDetails(version: CompetitionDetails.subscribe),
    "/competition-manage" : (context) => const CompetitionDetails(version: CompetitionDetails.manageSubscription),
    "/competition-finished" : (context) => const CompetitionDetails(version: CompetitionDetails.finished),
    "/competition-organizer" : (context) => const CompetitionDetails(version: CompetitionDetails.organizer),
    "/view_competitions" : (context) => const ViewCompetitions(),
    "/subscriptions" : (context) => const Subscriptions(),
    "/profile" : (context) => const Profile(),
    "/notifications" : (context) => const Notifications(),
    "/competition_options" : (context) => const CompetitionsOptions(),
    "/competitions" : (context) => const Competitions(),
    "/competitions2" : (context) => const Competitions2(),
    "/competitions3" : (context) => const Competitions3(),
    "/competitions-edit" : (context) => const Competitions(editMode: true),
    "/competitions2-edit" : (context) => const Competitions2(editMode: true),
    "/competitions3-edit" : (context) => const Competitions3(editMode: true),
    "/subscribe" : (context) => const Subscribe(),
    "/edit_competitions" : (context) => const EditCompetitions(),
    "/players" : (context) => const Players(),
    "/view_matches" : (context) => const Matches(),
    "/edit_matches" : (context) => const Matches(editMode: true,),
  };
}