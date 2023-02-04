# Parking Meter App

## Author: Yonas Sisay

The Frontend for the Archa Coding Interview.

### Project requirements

- Flutter version - 3.0.5
- XCode Version - 14.2 - IPhone 14 Pro Max
- Android SDK - Andriod API 33 - Pixel 3A

### App Functionalities

- Street name search with suggestions provided
- Map View of search results availble
- Filtering of Parking Meter depedning on availablity of Credit Card or Tap and Go
- Dark Mode capabilites for users to access during different times of the day
- Parking Meter details display with link to map

### Project Implementions

In this project i have opted into to using a simple architecture. I have used providers to manage the state internally within the application and Models to represent the data interaction between the API calls

##### App State Provider

- Responsible for managing the state of the app. I have used this provider and dedicated it to only app related states in this case the state of whether the app is in dark mode or not.

##### Search Provider

- This provider is dedicated to just maintain the state of the search logic. this way on different pages i can get details regarding the search page eg: search results,number of hits etc .

##### Meter Provider

- This model might have the same logic as search but its distinction is that this will be used on later on in the project to act as a manager of making CRUD operations in relation to Parking Meters in the server.

### Known issues

- Since i am making these API calls without an API key the request limit will be an issue causing the application to crash

### Resources

- Using Maps in Flutter [Implementing Flutter Maps With OSM](https://techblog.geekyants.com/implementing-flutter-maps-with-osm/).
