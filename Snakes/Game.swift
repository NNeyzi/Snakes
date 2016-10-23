//
//  Game.swift
//  Snakes
//
//  Created by Nader Neyzi on 10/22/16.
//  Copyright © 2016 Nader Neyzi. All rights reserved.
//

import UIKit

protocol GameDelegate {
    func updatePlayerScore(player: Int)
}

class Game {
    var scores = [0,0]
    let players: [Player]
    let board: [[GameCell]]
    var timer = Timer()
    var isPlayer1Turn = true;
    var delegate:GameDelegate?
    var winningPosition: [Int]
    

    init(cells: [[GameCell]]) {
        self.board = cells

        let player1 = Player.init(color: .red, position: [4,0])
        let player2 = Player.init(color: .blue, position: [4,4])
        self.board[4][0].state = "player1"
        self.board[4][4].state = "player2"
        self.players = [player1,player2]
        self.winningPosition = [3,4]
    }

    func start() {
        //1.Change all board state to neutral
        //2.Move players to initial position
        //3.Update board states   ^combine with this
        //Set winning position

        self.timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(movePlayer), userInfo: nil, repeats: true)
    }

    @objc func movePlayer() {
        var player: Player
        var playerIndex: Int
        if isPlayer1Turn {
            playerIndex = 0
        }else {
            playerIndex = 1
        }
        player = self.players[playerIndex]

        //1.Find possible moves
        //2.Make random move

        if self.checkWin(player: player) {
            self.delegate?.updatePlayerScore(player: playerIndex)
            self.resetBoard()
        } else {
            self.isPlayer1Turn = !isPlayer1Turn
        }
    }

    func findPossibleMoves(player: Player) -> [[GameCell]] {
        //check left,right, up, down for forward movement
        //if none found return prevCell or nothing

        return [[self.board[0][1]]]
    }

    func checkWin(player: Player) -> Bool {
        return player.position == self.winningPosition
    }

    func resetBoard() {
        self.timer.invalidate()
        self.start()
    }

}
