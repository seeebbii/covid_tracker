import 'package:flutter/material.dart';

class CountryModel{
  String _country;
  int _cases;
  int _deaths;
  int _recovered;
  String _countryFlagUrl;
  int _active;

  CountryModel(this._country, this._cases, this._deaths, this._countryFlagUrl, this._active, this._recovered);

  int get active => _active;

  String get countryFlagUrl => _countryFlagUrl;

  int get deaths => _deaths;

  int get cases => _cases;

  String get country => _country;

  int get recovered => _recovered;
}