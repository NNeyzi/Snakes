//
//  GameCell.swift
//  Snakes
//
//  Created by Nader Neyzi on 10/22/16.
//  Copyright © 2016 Nader Neyzi. All rights reserved.
//

import UIKit

class GameCellView: UIView {
    var isOccupied: Bool
    var position: [Int]

    init(frame: CGRect, position: [Int]) {
        self.isOccupied = false
        self.position = position
        super.init(frame: frame)
    }

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
