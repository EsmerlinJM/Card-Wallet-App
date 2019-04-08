import 'package:flutter/material.dart';

class CardModel {
  List<CardResults> results;

  CardModel({this.results});

  CardModel.fromJson(Map<String, dynamic> json) {
    if (json['cardResults'] != null) {
      results = new List<CardResults>();
      json['cardResults'].forEach((v) {
        results.add(new CardResults.fromJson(v));
      });
    }
  }
}

class CardResults {
  String cardHolderName;
  String cardNumber;
  String cardMonth;
  String cardYear;
  String cardCvv;
  Color cardColor;
  String cardType;

  CardResults(
      {this.cardHolderName,
      this.cardNumber,
      this.cardMonth,
      this.cardYear,
      this.cardCvv,
      this.cardColor,
      this.cardType});

  CardResults.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    cardMonth = json['cardMonth'];
    cardYear = json['cardYear'];
    cardCvv = json['cardCvv'];
    cardColor = json['cardColor'];
    cardType = json['cardType'];
  }
}
