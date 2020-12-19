# QR-generator Code challenge

***

### API server
- A lambda function linked to REST server provides the random seed for the QR generation.
- Bash URL: [https://fq741r6kaj.execute-api.us-east-2.amazonaws.com/generate]()

- Function description


```dart 
exports.handler = async (event) => {
   if(event.httpMethod == 'GET'){
       return getSeed(event);
   }
};

const getSeed = event => {
    let time = new Date();
    let dtime = time.setSeconds(time.getSeconds() + 15);
    let seed = {
      seed:  makeSeed(33).toString(),
      expires_at: dtime
        
    }
        
    return {
        statusCode: 200,
        body: JSON.stringify(seed),
    }
    
}

/// generate random seed. 
/// function borrowed from
/// https://stackoverflow.com/questions/1349404/generate-random-string-characters-in-javascript

function makeSeed(length) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}

``` 

## Project Structure
```
.
+--_Lib
|	+--_Application			// Holds all the Bloc logic
|	+--_Core				// Holds helper functions and extensions
|	+--_Domain				// Holds all models and complex class objets unit to the platform
|	+--_Infrastructure		// Holds all models as in the Domain level but with primitive datatype
|	+--_Repository			// Holds all services to communicate with outside world
|	+--_Routes				// Holds routing map and generate routes file
+--_Test
|	+--_Unit
|	|	+--_Seed_Gen_Bloc_test
|	|	|	+-- seed_gen_bloc_test.dart
|	+-- seed_gen_repository_test.dart
+-- injection.dart
+-- qr_code_screen.dart
+-- home.dart
+-- main.dart
```


## Code facilitation
- State management with `Freezed flutter_bloc`
- Dependency injection with `GetIt` and `Injectable` 
- Testing with `bloc_test`
- Routing with `auto_route`
- Code generation with `build_runner`
- Healthy code base enforced with `lint` and the immutable pros of Kotlin provided by `dartz`
- HTTP client management/generator with `chopper`
- Continuous Integration with GitHub actions

## How to Run and Test 

1. Clone or Download the project
2. Update the package dependencies `flutter pub get`
3. Run the build runner and wait for Success message. `flutter pub run build_runner watch --delete-conflicting-outputs`
4. Run Unit test to check for regression `flutter test` (It should output: All tests passed!)
5. Build and run app in on device in release mode `flutter run --release`    


