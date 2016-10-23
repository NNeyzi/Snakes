//
//  Game.swift
//  Snakes
//
//  Created by Nader Neyzi on 10/22/16.
//  Copyright © 2016 Nader Neyzi. All rights reserved.
//

import UIKit

protocol GameDelegate {
    func updatePlayerScore(playerIndex: Int)
    func updateBoardView(newMove: [Int], playerIndex: Int)
    func resetBoardView()
    func setWinningCellColor(position: [Int])
}

class Game {
    var scores = [0,0]
    var players: [Player]
    let startingBoard: [[GameCellView]]
    var board: [[GameCellView]]
    var timer = Timer()
    var currentPlayerIndex: Int
    var delegate:GameDelegate?
    var winningPosition: [Int]

    init(cells: [[GameCellView]]) {
        startingBoard = cells
        board = startingBoard
        players = []
        winningPosition = []
        currentPlayerIndex = 0
    }

    func start() {
        board = startingBoard
        players = [Player.init(color: .red, position: [0,0]),Player.init(color: .blue, position: [4,4])]
        currentPlayerIndex = 0
        board[0][0].isOccupied = true
        board[4][4].isOccupied = true
        setWinningPosition()

        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(movePlayerAndCheckWin), userInfo: nil, repeats: true)
    }

    @objc func movePlayerAndCheckWin() {
        makeRandomMove(possibleMoves: self.findPossibleMoves())

        if self.checkWin() {
            delegate?.updatePlayerScore(playerIndex: currentPlayerIndex)
            resetBoard()
        } else {
            if currentPlayerIndex == 0 {
                currentPlayerIndex = 1
            }else {
                currentPlayerIndex = 0
            }
        }
    }

    func setWinningPosition() {
        var winI = arc4random_uniform(5)
        var winJ = arc4random_uniform(5)
        if winI == 0 && winJ == 0 {
            winI += arc4random_uniform(4) + 1
        }
        if winI == 4 && winJ == 4 {
            winJ -= arc4random_uniform(4) + 1
        }
        winningPosition = [Int(winI),Int(winJ)]
        delegate?.setWinningCellColor(position: winningPosition)
    }

    func findPossibleMoves() -> [[Int]] {
        var possibleMoves: [[Int]] = []
        var lastMove = players[currentPlayerIndex].moves.last!
        let y = lastMove[0]
        let x = lastMove[1]
        //Left
        if x-1 >= 0 && !board[y][x-1].isOccupied  {
            possibleMoves.append([y,x-1])
        }
        //Right
        if x+1 < 5 && !board[y][x+1].isOccupied  {
            possibleMoves.append([y,x+1])
        }
        //Up
        if y-1 >= 0 && !board[y-1][x].isOccupied  {
            possibleMoves.append([y-1,x])
        }
        //Down
        if y+1 < 5 && !board[y+1][x].isOccupied  {
            possibleMoves.append([y+1,x])
        }
        //if no new moves, backtrack
        let currentPlayer = players[currentPlayerIndex]
        if possibleMoves.count == 1 && possibleMoves[0] == currentPlayer.lastBackTrack {
            possibleMoves.removeAll()
        }
        return possibleMoves
    }

    func makeRandomMove(possibleMoves: [[Int]]) {
        var move: [Int]
        if possibleMoves.count == 0 {
            if arc4random_uniform(2) == 0 {
                move = players[currentPlayerIndex].goBack()
                delegate?.updateBoardView(newMove: move, playerIndex: currentPlayerIndex)
                board[move[0]][move[1]].isOccupied = false
            }
        }else {
            let randomIndex = arc4random_uniform(UInt32(possibleMoves.count))
            move = possibleMoves[Int(randomIndex)]
            players[currentPlayerIndex].moveTo(position: move)
            delegate?.updateBoardView(newMove: move, playerIndex: currentPlayerIndex)
            board[move[0]][move[1]].isOccupied = true
        }
    }

    func checkWin() -> Bool {
        return players[currentPlayerIndex].moves.last! == winningPosition
    }

    func resetBoard() {
        timer.invalidate()
        delegate?.resetBoardView()
    }

}
