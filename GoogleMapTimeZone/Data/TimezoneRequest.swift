//
//  MapRequest.swift
//  GoogleMapTimeZone
//
//  Created by Ken Phanith on 2018/06/12.
//  Copyright © 2018 Quad. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

extension APIClient.Timezone {
    struct TimezoneRequest: RequestType {
        typealias Response = APIClient.Timezone.ResponseTimezone
        
        let location: String
        let timestamp: Double
        
        var path: String {
            return "/maps/api/timezone/json"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var parameters: Any? {
            let params = [
                "location": self.location,
                "timestamp": self.timestamp,
                "key": "AIzaSyCdLwlWLCLHRrXFJ5OYUM8gEvVUOdg4lis"
                ] as [String : Any] as [String : Any]
            return params
        }
    }
    
    struct ResponseTimezone: Himotoki.Decodable {
        let dstOffset: Int
        let rawOffset: Int
        let status: String
        let timeZoneId: String
        let timeZoneName: String
        
        static func decode(_ e: Extractor) throws -> APIClient.Timezone.ResponseTimezone{
            return try ResponseTimezone(
                dstOffset: e <| "dstOffset",
                rawOffset: e <| "rawOffset",
                status: e <| "status",
                timeZoneId: e <| "timeZoneId",
                timeZoneName:  e <| "timeZoneName"
            )
        }
    }
}
