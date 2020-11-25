import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:steam_lib/exceptions/network_exception.dart';
import 'package:steam_lib/models/steam_games.dart';
import 'package:steam_lib/models/steam_user.dart';
import 'package:steam_lib/repositories/steam_repository.dart';

part 'steam_state.dart';

class SteamCubit extends Cubit<SteamState> {
  final SteamRepository _steamRepository;

  SteamCubit(this._steamRepository) : super(SteamInitial());

  Future<void> getUserProfile(String steamId) async {
    try {
      emit(SteamUserLoading());
      final profile = await _steamRepository.getUserProfileAsync(steamId);
      emit(SteamUserLoaded(steamUser: profile));
    } on NetworkException catch (e) {
      emit(SteamUserError(errorMessage: e.message));
    }
  }

  Future<void> getFriendsProfile(String steamId) async {
    try {
      emit(SteamFriendsLoading());
      final friends = await _steamRepository.getFriendsProfileAsync(steamId);
      emit(SteamFriendsLoaded(steamFriends: friends));
    } on NetworkException catch (e) {
      emit(SteamFriendsError(errorMessage: e.message));
    }
  }

  Future<void> getGamesLibrary(String steamId) async {
    try {
      emit(SteamGamesLoading());
      final games = await _steamRepository.getGamesLibraryAsync(steamId);
      emit(SteamGamesLoaded(steamGames: games));
    } on NetworkException catch (e) {
      emit(SteamGamesError(errorMessage: e.message));
    }
  }
}
