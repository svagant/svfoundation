//
//  Result.swift
//  SVFoundation
//
//  Created by Stanislav Smida on 08/07/2018.
//  Copyright © 2018 Svagant, s.r.o. All rights reserved.
//

import Foundation

public enum Result<T> {
    case failure(Error)
    case success(T)
}

extension Result {
    
    /// - todo: Add @autoclosure when https://bugs.swift.org/browse/SR-487 is resolved.
    public init(_ closure: () throws -> T) {
        do {
            self = .success(try closure())
        } catch {
            self = .failure(error)
        }
    }
    
    public func resolve() throws -> T {
        switch self {
        case .failure(let error): throw error
        case .success(let value): return value
        }
    }
    
    public func toOptional() -> Optional<T> {
        switch self {
        case .failure(_): return Optional<T>.none
        case .success(let value): return Optional<T>.some(value)
        }
    }
}

public typealias ResultClosure<T> = (Result<T>) -> ()
