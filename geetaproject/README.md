# GeetaProject - Shrimad Bhagavad Gita

**GeetaProject** is a Flutter application designed to provide access to the sacred text of the Bhagavad Gita. It allows users to view, download, and save verses (sloks) of the Bhagavad Gita, with options for offline access and various translations and commentaries. The app uses Hive for local storage, allowing users to access saved sloks even without an internet connection.

---

| Section | Preview |
|--------|---------|

| Home | <a href="https://vimeo.com/1215457920?fl=tl&fe=ec"><img src="assets/home_screen.jpg" width="220"/></a> |
| Saved Collection Section | <a href="https://vimeo.com/1215457917?fl=tl&fe=ec"><img src="assets/saved_sloks.jpg" width="220"/></a> |
| Offline Saved | <a href="https://vimeo.com/1215457919?fl=tl&fe=ec"><img src="assets/offline_sloks.jpg" width="220"/></a> |


## Features

- View **Chapters** and **Sloks** (verses) from the Bhagavad Gita.
- View **translations** and **commentaries** from different authors.
- **Download** sloks for offline use.
- **Save** sloks to custom lists (e.g., favorites).
- Offline functionality with **Hive** for caching sloks and chapters.
- **Dark theme** designed for comfortable reading.

---

## Table of Contents

- [Installation](#installation)
- [Architecture](#architecture)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Tech Stack](#tech-stack)
- [Contributing](#contributing)
- [Acknowledgements](#Acknowledgements)

---

## Installation

To get started with this project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/MilanPatel03/Flutter_dev.git


2. Navigate to the project directory:

cd Flutter_dev


3. Install the dependencies:

flutter pub get


4. Run the app:

flutter run

## Architecture
The app follows a Clean Architecture structure, ensuring separation of concerns and making the codebase modular, maintainable, and testable.

### Folder Structure

```plaintext
lib/
├── models/
│   ├── autherscontentmodel.dart
│   ├── geetachaptermodel.dart
│   ├── geetaslokmodel.dart
│   ├── geetaslokmodel.g.dart
│   ├── geetachaptermodel.g.dart
│   ├── autherscontentmodel.g.dart
│   ├── savelistmodel.dart
│   └── savelistmodel.g.dart
│
├── providers/
│   └── geetaprovider.dart
│
├── repositories/
│   └── geetarepository.dart
│
├── services/
│   └── geetaservices.dart
│
├── ui/
│   ├── offline/
│   │   ├── offlineslokdetailscreen.dart
│   │   └── offlineslokscreen.dart
│   └── views/
│       └── (UI views for main app screens)
└── main.dart
```


### Architecture Layers and Responsibilities

#### 1. Models (Data Layer)

- Contains classes representing data structures for sloks, chapters, translations, etc.
- Includes logic for serializing data from JSON format and deserializing it back into Dart objects.
- Models are also used for interacting with **Hive** for local storage.

#### 2. Providers (State Management)

- Manages the state of the application and provides data to the UI.
- Uses **ChangeNotifier** to notify UI components when data changes.
- Handles business logic such as fetching data from repositories and managing loading states.

#### 3. Repositories (Data Access)

- Acts as an intermediary between the services and providers, abstracting the data-fetching logic.
- Fetches data either from the API (via services) or from local storage (via Hive).

#### 4. Services (API Layer)

- Handles making API calls to remote servers using the **http** package.
- Processes the response and converts it into appropriate data models.

#### 5. UI Layer

- Contains all screens and widgets that are visible to the user.
- UI components are decoupled from data-fetching logic and use Providers to access necessary data.
- Screens are created using `StatelessWidget` or `StatefulWidget`.

---

### Usage

#### Main Features

- **Offline Access**: Once a slok is downloaded, it is stored locally using **Hive** and can be accessed offline.
- **Slok Viewer**: View detailed information about each slok, including:
  - Slok text in **Sanskrit**
  - **Transliteration** for easy pronunciation
  - Translations in **English** and **Hindi**
  - Commentary from various authors
- **Saving Sloks**: Create custom lists and add sloks to these lists for easy access later.
- **Chapter List**: View all chapters in the Bhagavad Gita and navigate to any specific chapter and verse.

---

### Project Structure

#### Models

- Represents data structures for sloks, chapters, translations, and saved lists.
- Each model includes methods for **fromJson** and **toJson**.
- Hive adapters are included for offline persistence.

#### Providers

- `GeetaProvider` is the main provider that interacts with repositories.
- Uses **ChangeNotifier** to update the UI on state changes.

#### Repositories

- `GeetaRepository` interacts with the **GeetaServices** layer.
- Abstracts API and local storage logic.

#### Services

- `GeetaServices` handles external API communication.
- Uses the **http** package for network requests.

#### UI

- Built using **Flutter** widgets.
- Includes offline browsing screens and detailed slok views.

---

### Tech Stack

- **Flutter** – Cross-platform mobile framework
- **Dart** – Programming language
- **Hive** – Local NoSQL database
- **HTTP** – Network requests
- **Provider** – State management
- **JSON** – Data interchange format

### Contributing

We welcome contributions from the community! To contribute:

1. Fork this repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
3. Make your changes.
4. Commit your changes (git commit -am 'Add your feature').

5. Push to your branch (git push origin feature/your-feature-name).

6. Create a new Pull Request.

Please make sure that your code follows the project's coding standards and includes relevant tests.

### Acknowledgements

-Thanks to the Vedic Scriptures API for providing Bhagavad Gita data.

-Special thanks to the Flutter community for their continuous support and amazing resources.

