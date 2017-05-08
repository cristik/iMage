//
//  Mutex.swift
//  iMage
//
//  Created by Cristian Kocza on 08/05/2017.
//  Copyright © 2017 cristik. All rights reserved.
//

import Darwin

class Mutex {
    enum `Type` {
        case normal
        case errorCheck
        case recursive
        case `default`
        
        var mutexTypeValue: Int32 {
            switch self {
            case .normal: return PTHREAD_MUTEX_NORMAL
            case .errorCheck: return PTHREAD_MUTEX_ERRORCHECK
            case .recursive: return PTHREAD_MUTEX_RECURSIVE
            case .default: return PTHREAD_MUTEX_DEFAULT
            }
        }
    }
    private var mutex = pthread_mutex_t()
    
    init(type: Type = .default) {
        var attr = pthread_mutexattr_t()
        guard pthread_mutexattr_init(&attr) == 0 else {
            preconditionFailure()
        }
        pthread_mutexattr_settype(&attr, type.mutexTypeValue)
        guard pthread_mutex_init(&mutex, &attr) == 0 else {
            preconditionFailure()
        }
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    func locked<T>(_ closure: () -> T) -> T{
        pthread_mutex_lock(&mutex)
        defer { pthread_mutex_unlock(&mutex) }
        return closure()
    }
}
