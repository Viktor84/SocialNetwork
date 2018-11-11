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
    case getAPI(page: Int, size: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getAPI:
           return .get
        }
    }
    
    var url: String {
        let baseURL = "https://randomuser.me/api/"
        switch self {
        case .getAPI(let page, let size):
            return baseURL + "?page=\(page.toString())&results=\(size.toString())&seed=abc"
        }
    }
}
