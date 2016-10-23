//
//  ViewController.swift
//  Snakes
//
//  Created by Nader Neyzi on 10/22/16.
//  Copyright © 2016 Nader Neyzi. All rights reserved.
//

import UIKit




class ViewController: UIViewController, GameDelegate {
    @IBOutlet weak var gameBoardView: UIView!
    @IBOutlet weak var player1ColorView: UIView!
    @IBOutlet weak var player2ColorView: UIView!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    var cells = [[GameCell]]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.cells.count == 0 {
            self.cells = [[],[],[],[],[]]
            let cellEdgeLength = self.gameBoardView.frame.height/5
            var cellX:CGFloat = 0
            var cellY:CGFloat = 0
            for i in 0..<5 {
                for j in 0..<5{
                    let cell = GameCell.init(frame: CGRect(x: cellX, y: cellY, width: cellEdgeLength, height: cellEdgeLength), position: [i,j])
                    cell.backgroundColor = UIColor.red
                    self.gameBoardView.addSubview(cell)
                    self.cells[i].append(cell)
                    cellX += cellEdgeLength
                }
                cellX = 0
                cellY += cellEdgeLength
            }
            // TODO: make this shorter 
            let game = Game.init(cells: self.cells)
            game.delegate = self
            game.start()
        }
    }

    func updatePlayerScore(player: Int) {
        if player == 0 {
            let newScore = Int(self.player1ScoreLabel.text!)! + 1
            self.player1ScoreLabel.text = "\(newScore)"
        }else {
            let newScore = Int(self.player2ScoreLabel.text!)! + 1
            self.player2ScoreLabel.text = "\(newScore)"
        }
    }

}

