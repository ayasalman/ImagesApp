Photo Gallery App

This is an iOS application built with UIKit and Alamofire that displays a collection of photos fetched from the Picsum API. The app allows users to view a grid of images, tap on any photo to view it in full screen, and gracefully handles fallback images when the network fails.

Features

Fetches a list of random photos from the Picsum API.

Displays images in a UICollectionView.

Taps on any photo to view it in full-screen mode.

Handles network errors by showing local fallback images.

Uses Alamofire for networking.


Requirements
iOS 13.0+

Xcode 14.2

Swift 5.0

Alamofire package


Installation

Clone this repository:

Open the project in Xcode.

Build and run the app on a simulator or device.


How It Works

On launch, the app calls fetchPhotos() to fetch photo data from Picsum API.

Displays each image in a collection view grid.

If API fails, shows fallback images stored locally.

On selecting an image, opens it in full-screen mode with a dark background.

Tap anywhere to dismiss the full-screen image.
