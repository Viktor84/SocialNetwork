//
//  JSONRespone.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 02.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation

struct JSONResponse: Codable {
    let results: [JSONUser]
}

struct JSONUser: Codable {
    let name: JSONName
    let email: String
    let login: JSONLogin
    let phone: String
    let picture: JSONPicture
}

struct JSONName: Codable {
    let first: String
    let last: String
}

struct JSONLogin: Codable {
    let uuid: String
}

struct JSONPicture: Codable {
    let medium: String?
}

