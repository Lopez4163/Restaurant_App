# Restaurant App
Overview
------------
The Restaurant App is a Flutter application designed to display a list of restaurants and provide search functionality to filter the list based on the restaurant name. The app utilizes Riverpod for state management to ensure efficient and reactive updates.

<p align="center">
  <a href="https://github.com/Lopez4163/flutter_app/blob/main/assets/gif/app-demo.gif?raw=true">
    <img src="https://github.com/Lopez4163/flutter_app/blob/main/assets/gif/app-demo.gif?raw=true" alt="App Demo">
  </a>
</p>


------------

Load Restaurant Data: Fetches and loads restaurant data from a local JSON file.

Display Restaurant Names: Shows a list of restaurant names with their corresponding cuisine.

Search and Filter: Implements a search bar that filters the list of restaurants in real-time based on user input.

State Management: Uses Riverpod for managing the state of the restaurant list and search query.

Installation
--------------

**Clone the Repository**
Bash
```
git clone https://github.com/Lopez4163/flutter_app.git
```
**Install Dependencies**
Ensure you have Flutter installed. Run the following command to get the required dependencies:

Bash
```
flutter pub get
```

**Run the App**
A mobile simulator must be started, use the following command to start an ios simulator:<br>
*- Utilize Any Simulator You Want*<br>
*- Will Need Excode for This Command To work*

```
flutter emulators --launch ios
```

Once the simulator is fully booted run the command below to start the application:
```
flutter run
```
After a few seconds the simulator should display the application.

**ANOTHER OPTION:**

If that doesnt work you can select the main.dart file in the /lib directory in your IDE. Run the simulator and once booted use the run command or debugger on your IDE.


Usage
------
Upon running the app, you will see a list of restaurant names and their cuisines. Use the search bar at the top of the screen to filter the list by restaurant name or cuisine.

**Selecting a Restaurant
To view details about a restaurant:**

**Tap on a Restaurant**: From the list of restaurants, tap on any restaurant item.
View Details: You will be navigated to a detailed view of the selected restaurant. This screen displays additional information including the restaurant's slogan, phone number, and address, along with its image.
Viewing Restaurant Information
In the Restaurant Details Screen:

**Image**: Displays a large image of the restaurant.
Slogan: Shows a catchy slogan for the restaurant.
Phone Number: Provides a contact number with a phone emoji for visual appeal.
Address: Shows a fake address for demonstration purposes, prefixed with a map emoji.


State Management with Riverpod
---------------------------------

The application uses Riverpod for state management. Key providers include:

restaurantListProvider: Loads the restaurant list from the JSON file.

searchQueryProvider: Manages the state of the search query.

filteredRestaurantListProvider: Filters the list of restaurants based on the search query.

Filtering Logic:
--------------

The Restaurant App implements a real-time filtering mechanism that allows users to search for restaurants by name or cuisine. The filtering logic is based on the following steps:

1.  **User Input**: The user types a search query in the search bar at the top of the screen.
    
2.  **State Update**: The `_searchQuery` state variable is updated with the user's input using the `setState` method.
    
3.  **Data Filtering**: The `FutureBuilder` widget rebuilds the UI with the filtered list of restaurants. The filtering is done using the `where` method, which iterates over the list of restaurants and checks if the restaurant's name or cuisine contains the search query (case-insensitive).
    
4.  **Filtered List**: The filtered list of restaurants is then passed to the `ListView.builder` widget, which displays the filtered list of restaurants.
        
Resources
------------
If you need assistance setting up your flutter environment i recommend the following resources:

**Flutter Docs:** https://docs.flutter.dev/get-started/install?_gl=1

**Flutter Environment Setup Tutorial:** https://www.youtube.com/watch?v=Csguwudo5U4&t=886s

Contact
------
For any questions or inquiries, please contact:

Name: Nicholas Lopez

Email: Lopez4163@gmail.com

GitHub: https://github.com/Lopez4163
