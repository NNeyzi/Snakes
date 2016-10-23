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
    var position: [Int]

    init() {
        self.color = UIColor.black
        self.position = [0,0]
    }

    init(color: UIColor, position: [Int]) {
        self.color = color
        self.position = position
    }
}
