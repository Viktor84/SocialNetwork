//
//  Endpoint.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 02.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case getAPI
    
    var method: HTTPMethod {
        switch self {
        case .getAPI:
           return .get
        }
    }
    
    var url: String {
        let baseURL = "https://randomuser.me/api/"
        switch self {
        case .getAPI:
            return baseURL + "?results=15" // 1 ver
            //return baseURL + "?results=25&inc=gender,name,email,phone,picture" // 1.1 ver
            //return baseURL + " ?results=5&nat=gb,us,es&format=json" // 2 ver
        }
    }
}
