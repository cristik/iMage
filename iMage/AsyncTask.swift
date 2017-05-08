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
    private(set) var state = AsyncTaskState<T>.pending {
        didSet {
            switch state {
            case let .success(value): successCallbacks.forEach { $0(value) }
            case let .failure(error): failureCallbacks.forEach { $0(error) }
            case .pending: break
            }
            successCallbacks.removeAll()
            failureCallbacks.removeAll()
        }
    }
    private let mutex = Mutex()
    private var successCallbacks = [(T) -> Void]()
    private var failureCallbacks = [(Error) -> Void]()
    
    @discardableResult
    public func onSuccess(_ callback: @escaping (T) -> Void) -> AsyncTask<T> {
        mutex.locked {
            switch state {
            case .pending: successCallbacks.append(callback)
            case let .success(value): callback(value)
            case .failure: break
            }
        }
        return self
    }
    
    @discardableResult
    public func onFailure(_ callback: @escaping (Error) -> Void) -> AsyncTask<T> {
        mutex.locked {
            switch state {
            case .pending: failureCallbacks.append(callback)
            case .success: break
            case let .failure(error): callback(error)
            }
        }
        return self
    }
    
    @discardableResult
    public func onCompletion(_ callback: @escaping (Result<T>) -> Void) -> AsyncTask<T>  {
        mutex.locked {
            switch state {
            case .pending:
                successCallbacks.append( { callback(.value($0)) })
                failureCallbacks.append( { callback(.error($0)) })
            case let .success(value): callback(.value(value))
            case let .failure(error): callback(.error(error))
            }
        }
        return self
    }
    
    public func reportSuccess(with value: T) {
        mutex.locked {
            guard case .pending = state else { return }
            state = .success(value)
        }
        
    }
    
    public func reportFailure(with error: Error) {
        mutex.locked {
            guard case .pending = state else { return }
            state = .failure(error)
        }
    }
}
