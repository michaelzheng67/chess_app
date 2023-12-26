//
//  DataModel.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-04.
//

import AVKit
import RealityKit
import SwiftUI


@Observable
class DataModel {
    var playerTurn = 0 // 0 -> user's turn, 1 -> bot / opponent turn
    var botCompleted = 0 // 1 -> done computing, 0 -> async bot task still running
    var botLevel = 1 // correponds to the depth level of the minmax algorithm
    var turn = 0 // # of turns played
    var playerClock = 0 // how long user takes
    var botClock = 0 // how long bot takes
    var isTimed = false // player can choose if game is being timed or not
    
    var piecePlacement = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "piece_placement", withExtension: "mp3")!) // when user / bot places chess piece
    
    func placedPieceSound() {
        piecePlacement.play()
    }
}
