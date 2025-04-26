import 'package:dog_breeds/models/dog_breed.dart';
import 'package:dog_breeds/providers/app_provider.dart';
import 'package:dog_breeds/screens/detail_screen.dart';
import 'package:dog_breeds/widgets/image_viewer.dart';
import 'package:dog_breeds/widgets/loading_widget.dart';
import 'package:dog_breeds/widgets/title_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Future<void> _fetchDogBreeds() async {
    await Provider.of<AppProvider>(context, listen: false).fetchDogBreeds();
  }

  @override
  void initState() {
    super.initState();
    _fetchDogBreeds();
  }


  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<AppProvider>(context, listen: true).isLoading;
    List<DogBreed> dogBreeds = Provider.of<AppProvider>(context, listen: true).dogBreeds;
    bool darkMode = Provider.of<AppProvider>(context, listen: true).darkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets),
            Text(' Dog Breeds'),
          ],
        ),
        actions: [
          IconButton(
            icon: darkMode ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false).toggleDarkMode();
            },
          ),
        ],
      ),
      body: isLoading ? loadingWidget() :  dogBreeds.isNotEmpty ? ListView.builder(
        itemCount: dogBreeds.length,
        itemBuilder: (context, index) {
          final dogBreed = dogBreeds[index];
          return ListTile(
            title: titleCaseWidget(dogBreed.name),
            subtitle: Text(dogBreed.subbreeds.isEmpty ? 'No sub-breeds' : dogBreed.subbreeds.join(', ')),
            leading: ImageViewer(dogBreed),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              if (!Provider.of<AppProvider>(context, listen: false).dogBreedImages.containsKey(dogBreed.name)) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(dogBreed),
                ),
              );
            }
          );
        }) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Unable to fetch dog breed, check your internet connection'),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  _fetchDogBreeds();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ),
        ),
    );
  }
}