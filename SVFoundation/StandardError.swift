import Foundation

/**
 A type that represents ["unexpected" error](https://github.com/apple/swift/blob/master/docs/ErrorHandling.rst#unexpected-and-universal-errors)
 as a temporary solution till it is implemented in standard library.
 
 Use where something unexpected happened and you rather want to continue the
 program than crash. This should be considered a critical error and reported.
 A logic failure that arises from a programmer mistake and should not be
 recoverable at all.
 */

public struct UnexpectedError: LocalizedError {
    
    public init(errorDescription: String?, failureReason: String? = nil, recoverySuggestion: String? = nil, helpAnchor: String? = nil) {
        self.errorDescription = errorDescription
        self.failureReason = failureReason
        self.recoverySuggestion = recoverySuggestion
        self.helpAnchor = helpAnchor
    }
    
    public let errorDescription: String?
    public let failureReason: String?
    public let recoverySuggestion: String?
    public let helpAnchor: String?
}

/**
 A type that represents ["universal" error](https://github.com/apple/swift/blob/master/docs/ErrorHandling.rst#unexpected-and-universal-errors)
 as a temporary solution till it is implemented in standard library.
 */

public struct UniversalError: LocalizedError {
    
    public init(errorDescription: String?, failureReason: String? = nil, recoverySuggestion: String? = nil, helpAnchor: String? = nil) {
        self.errorDescription = errorDescription
        self.failureReason = failureReason
        self.recoverySuggestion = recoverySuggestion
        self.helpAnchor = helpAnchor
    }
    
    public let errorDescription: String?
    public let failureReason: String?
    public let recoverySuggestion: String?
    public let helpAnchor: String?
}
