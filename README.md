# TheFallen

This repo holds the source code for a 

## Functions

- 

## Getting Started

These instructions will help you set up the project and get running on your local machine for both development and testing purposes.

### Prerequisites and System Requirements

- Minimum of 8GB RAM Machine
- Download Xcode
- Target Device: iPhone 11 Pro Max

### Installing

  - Clone this repository

      `https://github.com/TheNachi/TheFallen.git`
      
  - Visit the link below, sign up for a MapBox Account and follow the instruction to create your secret token and store it in a `.netrc` file in your home directory

      `https://docs.mapbox.com/ios/maps/guides/install/`
      #### Format for .netrc
      ```
      machine api.mapbox.com
      login mapbox
      password <INSERT SECRET API TOKEN>
      ```

  - cd TheFallen
  - run `pod install`
  - Open xcode and select a target device
  - Build the app with Xcode

### Testing

Run `CMD+U` on XCode to run all tests. 

### External Framework Used

Mapbox was used because of it's relative ease of customization of map tiles and fast loading due to custom tile generation

### Architecture

This project was built with the MVVM Architecture for ease of testing

## Versioning

    Semantic: X.Y.Z build B
    X : Major version (Big overhauls, API changes)
    Y : Minor version (features, updates, improvements etc.)
    Z : Patch version (bug fixes)

    B: latest build number from commit history. Always use the most recent number.

