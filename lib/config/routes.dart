import 'package:flutter/material.dart';
import '../features/auth/screens/otp_verification_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/profile_setup_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/live_feed/screens/live_feed_screen.dart';
import '../features/live_feed/screens/scoreboard_screen.dart';
import '../features/live_feed/screens/squad_screen.dart';
import '../features/live_feed/screens/match_info_screen.dart';
import '../features/my_game/screens/teams_screen.dart';
import '../features/my_game/screens/team_details_screen.dart';
import '../features/my_game/screens/create_team_screen.dart';
import '../features/my_game/screens/add_players_screen.dart';
import '../features/my_game/screens/team_stats_screen.dart';
import '../features/my_game/screens/team_matches_screen.dart';
import '../features/my_game/screens/team_leaderboard_screen.dart';
import '../features/my_game/screens/players_screen.dart';
import '../features/my_game/screens/matches_screen.dart';
import '../features/my_game/screens/tournament_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/highlights/screens/highlights_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/settings/screens/about_us_screen.dart';
import '../features/settings/screens/privacy_policy_screen.dart';
import '../features/settings/screens/terms_conditions_screen.dart';
import '../features/settings/screens/user_profile_screen.dart';
import '../features/notifications/screens/notifications_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/team_profile/screens/team_profile_screen.dart';
import '../features/tournament/screens/tournament_dashboard_screen.dart';
import '../features/tournament/screens/create_tournament_screen.dart';
import '../features/match/screens/start_match_screen.dart';
import '../features/match/screens/match_details_screen.dart';
import '../features/match/screens/team_selection_screen.dart';
import '../features/match/screens/team_squad_screen.dart';
import '../features/match/screens/toss_screen.dart';
import '../features/match/screens/scorer_screen.dart';
import '../features/match/screens/player_selection_screen.dart';
import '../features/match/screens/scoring_screen.dart';
import '../features/match/screens/live_streaming_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signup = '/signup';
  static const String otpVerification = '/otp-verification';
  static const String profileSetup = '/profile-setup';
  static const String home = '/home';
  static const String liveFeed = '/live-feed';
  static const String scoreboard = '/scoreboard';
  static const String squad = '/squad';
  static const String matchInfo = '/match-info';
  static const String teams = '/teams';
  static const String teamDetails = '/team-details';
  static const String createTeam = '/create-team';
  static const String addPlayers = '/add-players';
  static const String teamStats = '/team-stats';
  static const String teamMatches = '/team-matches';
  static const String teamLeaderboard = '/team-leaderboard';
  static const String highlights = '/highlights';
  static const String settings = '/settings';
  static const String aboutUs = '/about-us';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';
  static const String userProfile = '/user-profile';
  static const String notifications = '/notifications';
  static const String chat = '/chat';
  static const String players = '/players';
  static const String teamProfile = '/team-profile';
  static const String matchesTab = '/matches-tab';
  static const String tournamentTab = '/tournament-tab';
  static const String tournamentDashboard = '/tournament-dashboard';
  static const String createTournament = '/create-tournament';
  static const String startMatch = '/start-match';
  static const String matchDetails = '/match-details';
  static const String teamSelection = '/team-selection';
  static const String teamSquad = '/team-squad';
  static const String toss = '/toss';
  static const String scorer = '/scorer';
  static const String playerSelection = '/player-selection';
  static const String scoring = '/scoring';
  static const String liveStreaming = '/live-streaming';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      signup: (context) => const SignupScreen(),
      otpVerification: (context) => const OtpVerificationScreen(),
      profileSetup: (context) => const ProfileSetupScreen(),
      home: (context) => const HomeScreen(),
      liveFeed: (context) => const LiveFeedScreen(),
      scoreboard: (context) => const ScoreboardScreen(),
      squad: (context) => const SquadScreen(),
      matchInfo: (context) => const MatchInfoScreen(),
      teams: (context) => const TeamsScreen(),
      teamDetails: (context) => const TeamDetailsScreen(),
      createTeam: (context) => const CreateTeamScreen(),
      addPlayers: (context) => const AddPlayersScreen(),
      teamStats: (context) => const TeamStatsScreen(),
      teamMatches: (context) => const TeamMatchesScreen(),
      teamLeaderboard: (context) => const TeamLeaderboardScreen(),
      highlights: (context) => const HighlightsScreen(),
      settings: (context) => const SettingsScreen(),
      aboutUs: (context) => const AboutUsScreen(),
      privacyPolicy: (context) => const PrivacyPolicyScreen(),
      termsConditions: (context) => const TermsConditionsScreen(),
      userProfile: (context) => const UserProfileScreen(),
      notifications: (context) => const NotificationsScreen(),
      chat: (context) => const ChatScreen(),
      players: (context) => const PlayersScreen(),
      teamProfile: (context) => const TeamProfileScreen(),
      matchesTab: (context) => const MatchesScreen(),
      tournamentTab: (context) => const TournamentScreen(),
      tournamentDashboard: (context) => const TournamentDashboardScreen(),
      createTournament: (context) => const CreateTournamentScreen(),
      startMatch: (context) => const StartMatchScreen(),
      matchDetails: (context) => const MatchDetailsScreen(),
      teamSelection: (context) => const TeamSelectionScreen(),
      teamSquad: (context) => const TeamSquadScreen(),
      toss: (context) => const TossScreen(),
      scorer: (context) => const ScorerScreen(),
      playerSelection: (context) => const PlayerSelectionScreen(),
      scoring: (context) => const ScoringScreen(),
      liveStreaming: (context) => const LiveStreamingScreen(),
    };
  }
}

