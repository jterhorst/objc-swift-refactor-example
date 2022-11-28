# Example of Refactoring Legacy ObjC code into Swift

## Goals:
1. Wrap the legacy code in tests
2. With the tests, add interfaces to allow injecting mocks for anything connected to our class.
3. Provide a new implementation in Swift, wrapped in a feature flag.
4. Duplicated tests should point to new implementation, ensuring it continues to provide the same result as the legacy implementation.

Exploring how we can refactor, test, and confidently replace an ObjC class with a Swift equivalent?
