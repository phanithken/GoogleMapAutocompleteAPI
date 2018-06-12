//
//  APIClient.swift
//  GoogleMapTimeZone
//
//  Created by Ken Phanith on 2018/06/12.
//  Copyright © 2018 Quad. All rights reserved.
//

import RxSwift
import APIKit
import Result


struct APIClient {
    
    public static var configuration = URLSessionConfiguration.default
    
    static var session: Session {
        self.configuration.urlCache?.diskCapacity   = 0
        self.configuration.urlCache?.memoryCapacity = 0
        
        return Session(adapter: URLSessionAdapter(configuration: configuration))
    }
    
    struct Timezone {
        static func getTimezone(location: String, timestamp: Double) -> Observable<APIClient.Timezone.ResponseTimezone> {
            return Session.ex.sendRequest(request: TimezoneRequest(location: location, timestamp: timestamp))
        }
    }
    
}
