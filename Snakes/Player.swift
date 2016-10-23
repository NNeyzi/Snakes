//
//  Player.swift
//  Snakes
//
//  Created by Nader Neyzi on 10/22/16.
//  Copyright © 2016 Nader Neyzi. All rights reserved.
//

import UIKit

struct Player {
    let color: UIColor
    var moves: [[Int]]
    var lastBackTrack: [Int]

    init() {
        self.color = UIColor.black
        self.moves = []
        self.lastBackTrack = []
    }

    init(color: UIColor, position: [Int]) {
        self.color = color
        self.moves = [position]
        self.lastBackTrack = []
    }

    mutating func moveTo(position: [Int]) {
        self.lastBackTrack = []
        moves.append(position)
    }

    mutating func goBack() -> [Int]{
        let move = moves.popLast()!
        self.lastBackTrack = move
        return move
    }

    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.color == rhs.color
    }
}
