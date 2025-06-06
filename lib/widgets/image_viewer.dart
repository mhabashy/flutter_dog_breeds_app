import 'dart:async';

import 'package:dog_breeds/models/dog_breed.dart';
import 'package:dog_breeds/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewer extends StatefulWidget {
  final DogBreed dogBreed;
  const ImageViewer(this.dogBreed, {super.key});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

  String? imageUrl;
  bool isLoading = true;

  void fetchDogBreedImages() async {
    try {
      imageUrl = await Provider.of<AppProvider>(context, listen: false).fetchDogBreedImages(widget.dogBreed.name);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching dog breed images: $e');
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDogBreedImages();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: isLoading ? const CircularProgressIndicator() : imageUrl != null ? Hero(
          tag: widget.dogBreed.name,
          transitionOnUserGestures: true,
          child: Image.network(
            imageUrl!,
            fit: BoxFit.fill,
            width: 240,
            height: 240,
          ),
        ) : const Icon(
          Icons.pets,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}