# Flutter Ecommerce Apps

This project contains specific e-commerce applications for purchasing shoes by implementing the chat apps feature. This project is also part of the [BuildWithAngga](https://buildwithangga.com/kelas/full-stack-laravel-flutter-2021-building-e-commerce-and-chat-apps?main_leads=topics) online course

<img src="https://github.com/msyamsularif/ecommerce-app/blob/main/assets/documentation/Mockup.png" width="683" height="384"/>

## Features

- Live chat feature
- Adding products to the shopping cart
- Adding products to the wishlist

## Tech

Flutter ecommerce apps use several open source packages found in [pub.dev](https://pub.dev/), including :

- [firebase_core](https://pub.dev/packages/firebase_core) - A Flutter plugin to use the Firebase Core API, which enables connecting to multiple Firebase apps.
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) - A Flutter plugin to use the Cloud Firestore API. 
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - To implement the state management Bloc
- [http](https://pub.dev/packages/http) - This package contains a set of high-level functions and classes that make it easy to consume HTTP resources.
- [equatable](https://pub.dev/packages/equatable) - Being able to compare objects in Dart often involves having to override the == operator as well as hashCode.

## Installation

to run this project first of all setup firebase for integration with the project, You can access the following guide [Flutter Doc Firebase](https://docs.flutter.dev/data-and-backend/firebase). Then add the **google-services.json** file to the `android>app` directory
- _android\app_
    - ![](https://github.com/msyamsularif/ecommerce-app/blob/main/assets/documentation/documentation%20directory.png)

and you can immediately run the flutter application with the following command
```sh
flutter pub get
flutter run lib/main.dart
```