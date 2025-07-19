
import 'dart:ffi';

import 'package:fit_food_app/business/data.dart';
import 'package:fit_food_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

final isProProvider = StateProvider<bool>((ref) => false);

final versionProvider = StateProvider<bool?>((ref) => null);

final dataControlProvider = Provider((ref) => DataKontrol());

final kategoriListesiProvider = StateProvider<List<KategoriModel>>((ref) => []);
final kaloriyeGoreKategoriList = StateProvider<List<KategoriModel>>((ref) => []);

final tarifListesiProvider = StateProvider<List<TarifModel>>((ref) => []);

final kahvaltiListProvider = StateProvider<List<TarifModel>>((ref) => []);

final ogleListProvider = StateProvider<List<TarifModel>>((ref) => []);

final aksamListProvider = StateProvider<List<TarifModel>>((ref) => []);

final araListProvider = StateProvider<List<TarifModel>>((ref) => []);

final mealListProvider = StateProvider<List<MealModel>>((ref) => []);




final kilo = StateProvider<double>((ref) => 0);
final boy = StateProvider<double>((ref) => 0);
final yas = StateProvider<int>((ref) => 0);
final cinsiyet = StateProvider<String>((ref) => "");
final aktiviteDuzeyi = StateProvider<double>((ref) => 0);
final hedef = StateProvider<String>((ref) => "");



final kaloriHedefi = StateProvider<int>((ref) => 0);
final alinanKalori = StateProvider<int>((ref) => 878);

final proteinHedefi = StateProvider<int>((ref) => 0);
final alinanProtein = StateProvider<int>((ref) => 0);

final carbHedefi = StateProvider<int>((ref) => 0);
final alinanCarb = StateProvider<int>((ref) => 0);

final yagHedefi = StateProvider<int>((ref) => 0);
final alinanYag = StateProvider<int>((ref) => 0);


