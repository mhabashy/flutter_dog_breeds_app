import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dog_breeds/config.dart';
import 'package:dog_breeds/models/dog_breed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AppProvider with ChangeNotifier {

  List<DogBreed> dogBreeds = [];
  bool isLoading = true;
  Map<String, String> dogBreedImages = {};
  bool darkMode = false;

  Future<void> fetchDogBreeds() async {
    try {
      final response = await http.get(
        Uri.parse('${Env.apiUrl}breeds/list/all'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] != 'success') {
          throw Exception('Failed to load dog breeds');
        }
        for (var breed in data['message'].keys) {
          dogBreeds.add(DogBreed.fromObjBody(breed, data['message'][breed]));
        }
        isLoading = false;
      } else {
        throw Exception('Failed to load dog breeds');
      }
    } catch (e) {
      BotToast.showText(
        text: 'Error fetching dog breeds: $e',
        duration: const Duration(seconds: 2),
        contentPadding: const EdgeInsets.all(10),
        textStyle: const TextStyle(color: Colors.white),
      );
      isLoading = false;
    }
    notifyListeners();
  }

  Future<String?> fetchDogBreedImages(String breed) async {
    try {
      if (dogBreedImages.containsKey(breed)) {
        return dogBreedImages[breed];
      }
      final response = await http.get(
        Uri.parse('${Env.apiUrl}breed/$breed/images/random'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] != 'success') {
          throw Exception('Failed to load dog breed images');
        }
        dogBreedImages[breed] = data['message'];
        return data['message'];
      } else {
        throw Exception('Failed to load dog breed images');
      }
    } catch (e) {
      BotToast.showText(
        text: 'Error fetching dog breed images: $e',
        duration: const Duration(seconds: 2),
        contentPadding: const EdgeInsets.all(10),
        textStyle: const TextStyle(color: Colors.white),
      );
      return null;
    }
  }

  void toggleDarkMode() {
    darkMode = !darkMode;
    notifyListeners();
  }

}