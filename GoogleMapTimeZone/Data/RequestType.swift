//
//  RequestType.swift
//  GoogleMapTimeZone
//
//  Created by Ken Phanith on 2018/06/12.
//  Copyright © 2018 Quad. All rights reserved.
//

import APIKit
import Himotoki

protocol RequestType: APIKit.Request {}

extension RequestType {
    
    
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com")!
    }
    
    var headerFields: [String: String] {
        return [
            "Accept": "application/json",
            "Accept-Encoding": "gzip",
            "Authorization" : "Bearer"
        ]
    }
    
}

// MARK: Decode
extension RequestType where Response: Himotoki.Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}
