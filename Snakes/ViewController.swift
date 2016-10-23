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
    var cells = [[GameCellView]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        player1ColorView.backgroundColor = UIColor.red
        player2ColorView.backgroundColor = UIColor.blue
        gameBoardView.backgroundColor = UIColor.yellow
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
                    let cell = GameCellView.init(frame: CGRect(x: cellX, y: cellY, width: cellEdgeLength, height: cellEdgeLength), position: [i,j])
                    cell.backgroundColor = UIColor.black
                    gameBoardView.addSubview(cell)
                    cells[i].append(cell)
                    cellX += cellEdgeLength
                }
                cellX = 0
                cellY += cellEdgeLength
            }
            cells[0][0].backgroundColor = player1ColorView.backgroundColor
            cells[4][4].backgroundColor = player2ColorView.backgroundColor
            let game = Game.init(cells: self.cells)
            game.delegate = self
            game.start()
        }
    }

    func updatePlayerScore(playerIndex: Int) {
        if playerIndex == 0 {
            let newScore = Int(self.player1ScoreLabel.text!)! + 1
            self.player1ScoreLabel.text = "\(newScore)"
        }else {
            let newScore = Int(self.player2ScoreLabel.text!)! + 1
            self.player2ScoreLabel.text = "\(newScore)"
        }
    }

    func updateBoardView(newMove: [Int], playerIndex: Int) {
        var playerColor: UIColor
        if playerIndex == 0 {
            playerColor = player1ColorView.backgroundColor!
        } else {
            playerColor = player2ColorView.backgroundColor!
        }
        
        if cells[newMove[0]][newMove[1]].backgroundColor != UIColor.black {
            cells[newMove[0]][newMove[1]].backgroundColor = UIColor.black
        }else {
            cells[newMove[0]][newMove[1]].backgroundColor = playerColor
        }
    }

    func resetBoardView() {
        cells.removeAll()
        viewDidLayoutSubviews()
    }

    func setWinningCellColor(position: [Int]) {
        cells[position[0]][position[1]].backgroundColor = UIColor.orange
    }
}

