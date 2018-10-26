import Foundation

/**
 A type that represents either a wrapped value or an error that failed
 production of that value. It basically is
 [Result<T>](https://github.com/apple/swift/blob/master/docs/ErrorHandling.rst#manual-propagation-and-manipulation-of-errors)
 but in swiftier style.
 
 The purpose of this type is to propagate possible error where Swift's natural
 error handling mechanism cannot be used. Particularly in asynchronous
 operations.
 
 - SeeAlso: `AsyncReturn`, `SpecificFailable`
 */
public enum Failable<T> {
    case failure(Error), ok(T)
    
    /**
     - Note: Using `@autoclosure` to pass expression rather than block here
     would be lovely but since it is likely that `try` call would be
     autoclosured it is better not to use if before
     [this](https://bugs.swift.org/browse/SR-487) is fixed.
     */
    public init(_ block: () throws -> T) {
        do {
            self = .ok(try block())
        } catch {
            self = .failure(error)
        }
    }
    
    public func unwrap() throws -> T {
        switch self {
        case let .failure(error):
            throw error
        case let .ok(value):
            return value
        }
    }
}

/**
 A type that represents either a wrapped value or an error of a specific type
 that failed production of that value.
 
 - Note: This is `Failable` in the manner of error
 [specificity](https://github.com/apple/swift/blob/master/docs/ErrorHandlingRationale.rst#specificity).
 While it states, that specificity may not work out for the best there
 certainly are cases where we can want to be specific with possible error type
 without compunctions:
 * In async error handling where we can't use natural error handling even if
 would want to.
 
 Good reasons may be below but it is not recomended. Be very reasonable if you
 choose it over natural error handling:
 * If you want to utilize strong type system in order to be exhaustive in
 expectation of possible errors.
 
 - Note: Since Swift's natural error handling mechanism doesn't support error
 specificity this type doesn't directly use do/try/catch (in opopsite to
 `Failable`) to not loose a specific error type. Use standard `switch` or
 `if case let` contructions to unwrap instead.
 
 - Todo: If [default generic arguments](https://github.com/apple/swift/blob/master/docs/GenericsManifesto.md#default-generic-arguments)
 and [specificity](https://github.com/apple/swift/blob/master/docs/ErrorHandlingRationale.rst#specificity)
 are implemented, this should be obsoleted and `Failable<T>` updated to
 `Failable<T, ErrorType: Error = Error>`.
 */
public enum SpecificFailable<T, ErrorType> where ErrorType: Error {
    case failure(ErrorType), ok(T)
    
    /**
     In case you need to swith to Swift error handling, transform to
     `Failable` from where you can do throwing unwrap.
     */
    public var failable: Failable<T> {
        switch self {
        case let .failure(error):
            return .failure(error)
        case let .ok(value):
            return .ok(value)
        }
    }
}
