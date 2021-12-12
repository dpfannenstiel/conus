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

