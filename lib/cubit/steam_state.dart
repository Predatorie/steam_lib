part of 'steam_cubit.dart';

abstract class SteamState extends Equatable {
  const SteamState();
}

class SteamInitial extends SteamState {
  @override
  List<Object> get props => [];
}

class SteamUserLoading extends SteamState {
  const SteamUserLoading();
  @override
  List<Object> get props => [];
}

class SteamUserLoaded extends SteamState {
  final ProfileDisplay steamUser;
  const SteamUserLoaded({@required this.steamUser});
  @override
  List<Object> get props => [steamUser];
}

class SteamUserError extends SteamState {
  final String errorMessage;
  const SteamUserError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class SteamFriendsLoading extends SteamState {
  const SteamFriendsLoading();
  @override
  List<Object> get props => [];
}

class SteamFriendsLoaded extends SteamState {
  final List<ProfileDisplay> steamFriends;
  const SteamFriendsLoaded({@required this.steamFriends});
  @override
  List<Object> get props => [steamFriends];
}

class SteamFriendsError extends SteamState {
  final String errorMessage;
  const SteamFriendsError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class SteamGamesLoading extends SteamState {
  const SteamGamesLoading();
  @override
  List<Object> get props => [];
}

class SteamGamesLoaded extends SteamState {
  final List<Game> steamGames;
  const SteamGamesLoaded({@required this.steamGames});
  @override
  List<Object> get props => [steamGames];
}

class SteamGamesError extends SteamState {
  final String errorMessage;
  const SteamGamesError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
