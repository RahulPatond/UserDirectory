//
//  User.swift
//  UserDirectory
//
//  Created by Rahul Patond on 17/02/26.
//

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let email: String
}
