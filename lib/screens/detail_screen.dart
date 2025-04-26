import 'package:dog_breeds/models/dog_breed.dart';
import 'package:dog_breeds/providers/app_provider.dart';
import 'package:dog_breeds/widgets/loading_widget.dart';
import 'package:dog_breeds/widgets/title_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final DogBreed dogBreed;
  const DetailScreen(this.dogBreed, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DogBreed dogBreed;
  late String imageUrl;
  // bool isLoading = true;

  // fetchImageUrl() async {
  //   try {
  //     imageUrl = await Provider.of<AppProvider>(context, listen: false).fetchDogBreedImages(dogBreed.name);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     SnackBar(
  //       content: Text('Error fetching dog breed images: $e'),
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    dogBreed = widget.dogBreed;
    imageUrl = Provider.of<AppProvider>(context, listen: false).dogBreedImages[dogBreed.name] ?? '';
    // fetchImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleCaseWidget(dogBreed.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: dogBreed.name, child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            )),
            const SizedBox(height: 20),
            Text(
              'Breed: ${dogBreed.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Sub-breeds: ${dogBreed.subbreeds.isEmpty ? 'No sub-breeds' : dogBreed.subbreeds.join(', ')}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 50),
          ]
        ),
      ),
    );
  }
}