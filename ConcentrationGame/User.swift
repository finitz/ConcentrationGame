//
//  User.swift
//  ConcentrationGame
//
//  Created by 17 on 11/8/19.
//  Copyright © 2019 17. All rights reserved.
//

import Foundation

class User: NSObject {
    static var shared = User(username: "user", password: "pass", score: 0)
    
    let username: String
    let password: String
    @objc dynamic var score: Int

    init(username: String, password: String, score: Int) {
        self.username = username
        self.password = password
        self.score = score
    }
}
