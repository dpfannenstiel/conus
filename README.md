# README.md

Conus is an implementation of [Wolfram Codes](https://en.wikipedia.org/wiki/Wolfram_code).  The system begins with Rule 31.

The UI allows the user to set the codes using a Bit-wise interface.  Once the bit has been changed the code value in the title will update and the generations of the cellular automata be redisplayed.  The Bit-wise interface is a [Big Endian](https://en.wikipedia.org/wiki/Endianness).  From an initial installation selection the 5th bit results in the sequence [off, off, off, on, off, on, on, off] or Rule 22 and is also visually appealing.

Selecting the edit button on the left hand side will pull up a panel with presets and a "Restore Defaults".  Also is a "Generations" slider to control how many vertical layers should be produced.  These changes do not take effect unless "Update" is selected.

## Running the Application

The application was build using Xcode 13 targeting iOS 15 and should be run with the same.  To run the application:

1. Open the file `Conus.xcodeproj` using Xcode 13
2. Select the target "Conus" from the scheme selector
3. Select an iPhone simulator running iOS 15 or later
	* NOTE: Testing was done on an iPhone 11 Simulator
4. Hit the build and run button to begin

### Running Tests

After opening the project, you may optionally choose to run tests to validate the model objects.  The Conus scheme is already configured for testing with code coverage.  With the scheme selected "CMD + U" will execute the tests.

## Implementation Details

Conus was implemented with an eye for Swift best practices and functional programming idioms.  While [Rule 30](https://en.wikipedia.org/wiki/Rule_30) includes an implementation of the algorithm to calculate subsequent generations, it was limited to Rule 30 alone.

### Model

Instead development was structured around issues of Swift architecture.  `WolframCode` illustrates a best practices approach to the use of error handling in Swift by using the internal type `WolframCode.Errors` to throw out of cases cases that are invalid.  These errors use associated values to supply error reporting additional information to consumers of the API. The use of `WolframCode.RulesModels` scopes relevant constants to the parent type.

`Generation` displays the power of Swift in creating types through `typealias`.  By redefining Arrays to be a Generation of data rather than just referencing them as Array, an additional level of type safety is provided to API consumers.  In the `Generation` extension, additional methods have been added to simplify testing and other API calls using preexisting functional programming methods.

### UI

The UI was written in SwiftUI, because if I'm going to spend a weekend writing code I'm going to work on my developing competencies.  The repeatedly used view to edit the `WolframCode` has been extrapolated into a `WolframCodeView`.  Editing the settings for generation are non-destructive to the state of the parent view.

There are opportunities in the UI for initial layout of the scrollview and to increase the performance when changing the generation count.

In the future it would probably be a good idea to add an in process web viewer.  That object doesn't exist in SwiftUI and is out of scope for the term of the project.  Hooks have been introduced to load to a Safari in the interim.  