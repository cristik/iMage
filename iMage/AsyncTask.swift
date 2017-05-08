//
//  AsyncTask.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

enum AsyncTaskState<T> {
    case pending
    case success(T)
    case failure(Error)
}

enum Result<T> {
    case value(T)
    case error(Error)
}

class AsyncTask<T> {
    private(set) var state = AsyncTaskState<T>.pending
    private var successCallbacks = [(T) -> Void]()
    private var failureCallbacks = [(Error) -> Void]()
    private var completionCallbacks = [(Result<T>) -> Void]()
    
    public func onSuccess(_ callback: @escaping (T) -> Void) {
        switch state {
        case .pending: successCallbacks.append(callback)
        case let .success(value): callback(value)
        case .failure: break
        }
    }
    
    public func onFailure(_ callback: @escaping (Error) -> Void) {
        switch state {
        case .pending: failureCallbacks.append(callback)
        case .success: break
        case let .failure(error): callback(error)
        }
    }
    
    public func onCompletion(_ callback: @escaping (Result<T>) -> Void) {
        switch state {
        case .pending:
            successCallbacks.append( { callback(.value($0)) })
            failureCallbacks.append( { callback(.error($0)) })
        case let .success(value): callback(.value(value))
        case let .failure(error): callback(.error(error))
        }
    }
}
