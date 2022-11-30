# Example of Refactoring Legacy ObjC code into Swift

This is an example project, containing the `SignalBox` class, illustrating a refactor of the legacy _SignalBox_ from ObjC to Swift.

## Goals:
1. Wrap the legacy code in tests
2. With the tests, add interfaces to allow injecting mocks for anything connected to our class.
3. Provide a new implementation in Swift, wrapped in a feature flag.
4. Duplicated tests should point to new implementation, ensuring it continues to provide the same result as the legacy implementation.

Exploring how we can refactor, test, and confidently replace an ObjC class with a Swift equivalent?

## Parts:

**Part 1:** The "starting point" directory illustrates our "legacy" ObjC project. There's a `SignalBox` which gets messages from `SimulatedBluetoothReceiver` gets messages often. It works, but the code is old and ugly. Many devs on the team want nothing to do with this code.
**Part 2:** Beginning our efforts to make this code behave well for Swift. We're not changing the design of these structures - rather, we're adding attributes to make clear what is expected from them. Nullability and other Swift intercompatibility attributes are the key here.
**Part 3:** Now that our Objective-C is a bit easier to consume in Swift, we're moving into the thought process of near-total test coverage of the legacy class. If it has dependencies, we should attempt to conform those to public interfaces in the form of protocols. Only the functions in the dependency which are used by our legacy ObjC are in-scope for this project. (We will later create mock classes conforming to those same protocols.) Take a note of any functions not used by our legacy class, as they could be considered as part of another class in future refactors - again, out of scope for this project.
**Part 4:** Implement a full blanket of unit tests around the legacy class. If the legacy class has tests that's great, but don't consider these as part of our "coverage" in this phase. Don't break the existing tests, since these may cover domain knowledge we're not aware of. Our new tests will attempt to cover any conditional cases and pathways between dependencies, getting as close to 100% coverage as possible. Visualize that you have a meter and are measuring the voltage in and out of an electrical device with a few buttons, and writing down the expected values in each configuration of buttons. This will be important for the next step.
**Part 5:** _Clone the test class, and create a Swift implementation to fulfill those tests._ 
