# To-Do App

## Overview

This application is a task manager that allows you to create, edit, and delete tasks. The app also allows users to prioritize tasks and mark tasks as completed.

## Requirements

Please make sure to use latest flutter version!

Clone this repository.
Run the following command to install the dependencies:
flutter pub get
Run the following command to run the app:
flutter run

## Usage

To create a new task, click on the "+" button in the action bar. On the "New Task" screen, enter a name for the task and select a priority. Click on the "Save" button to create the task.

To edit a task, click on the task in the task list. On the "Edit Task" screen, make the necessary changes and click on the "Save" button to update the task.

To delete a task, swipe the task to the left in the task list and click on the "Delete" button.

To mark a task as completed, click on the checkbox icon on the task in the task list. The task will be moved to the completed task list.

## Architecture

The app is built using the MVC (Model-View-Controller) architecture pattern. The model contains the data of the app, the view displays the data, and the Controller handles the user interaction.

Using changeNotifier/Provider for state management.

## Database

The app uses Firebase Firestore to store data.

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## BONUS

- Firebase integration
- Firestore database
- Form validation
- Simple UI using Material 3
- Working on iOS and Android
- Settings Unit tests
- Task Repository Unit tests

## Running the Project and Tests

### Steps to run the project:

1. Make sure you have the Flutter SDK installed on your system. You can find instructions on how to install Flutter in the [online Flutter documentation](https://flutter.dev/docs/get-started/install).
2. Make sure you are using the latest stable version of flutter.
3. Clone the project repository to your computer.
4. Open a terminal and navigate to the root directory of the project.
5. Run `flutter pub get` to install all necessary dependencies.
6. With an emulator open or a connected physical device, run `flutter run` to start the application.

### Steps to run the tests:

1. Open a terminal and navigate to the root directory of the project.
2. Run `flutter test` to execute all tests in the `test/` directory.
3. Test results will be displayed in the terminal.

Ensure that your development environment is properly set up to run Flutter applications and that you have an Android/iOS emulator available or a connected physical device to run the application.

## License

This app is licensed under the MIT License.
