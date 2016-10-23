//
//  GameCell.swift
//  Snakes
//
//  Created by Nader Neyzi on 10/22/16.
//  Copyright © 2016 Nader Neyzi. All rights reserved.
//

import UIKit

class GameCell: UIView {
    var state: String
    var position: [Int]

    init(frame: CGRect, position: [Int]) {
        self.state = "neutral"
        self.position = position
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
