//
//  Card.swift
//  ConcentrationGame
//
//  Created by 17 on 9/10/19.
//  Copyright © 2019 17. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    static var uniqueIdentifier = 0
    
    static func generateUniqueIdentifier() -> Int {
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    init() {
        self.identifier = Card.generateUniqueIdentifier()
    }
}
