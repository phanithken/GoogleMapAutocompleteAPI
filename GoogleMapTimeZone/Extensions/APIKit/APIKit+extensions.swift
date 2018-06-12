//
//  APIKit+extensions.swift
//  GoogleMapTimeZone
//
//  Created by Ken Phanith on 2018/06/12.
//  Copyright © 2018 Quad. All rights reserved.
//

import Foundation
import UIKit
import APIKit
import RxSwift

extension Session: ExtensionCompatible {}

extension Extension where Base == Session {
    
    func sendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { [unowned base] observer in
            let task = base.send(request) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    static func sendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return Session.shared.ex.sendRequest(request: request)
    }
}
