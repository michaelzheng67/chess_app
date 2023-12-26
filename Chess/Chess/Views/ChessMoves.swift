//
//  ChessMoves.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-20.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

struct ChessMoves {
    
    // pawn moves
    static func movePawn(row: Int, col: Int, move_x: Float, move_z: Float) ->  (Int, Int) {
        var (return_row, return_col) = (row, col)
        
        // move forward max 2 spaces
        return_row = moved_up_down(row: row, move_z: move_z)
        
        if return_row < row - 2 {
            return_row = row - 2
        } else if return_row > row {
            return_row = row
        }
        
        return (return_row, return_col)
        
    }
    
    // Rook moves
    static func moveRook(row: Int, col: Int, move_x: Float, move_z: Float) -> (Int, Int) {
        var (return_row, return_col) = (row, col)
        
        // can only move forwards or horizontal
        return_row = moved_up_down(row: row, move_z: move_z)
        return_col = moved_left_right(col: col, move_x: move_x)
        
        if return_row != row {
            return_col = col
        } else if return_col != col {
            return_row = row
        }
        
        return (return_row, return_col)
    }
    
    // Bishop moves
    static func moveBishop(row: Int, col: Int, move_x: Float, move_z: Float) -> (Int, Int) {
        var (return_row, return_col) = (row, col)
        
        // can only move diagonal
        return_row = moved_up_down(row: row, move_z: move_z)
        return_col = moved_left_right(col: col, move_x: move_x)
        
        let row_diff = abs(return_row - row)
        let col_diff = abs(return_col - col)
        
        // we need differences to be the same
        if row_diff == col_diff {
            return (return_row, return_col)
        }
        return (row, col)
    }
    
    // Knight moves
    static func moveKnight(row: Int, col: Int, move_x: Float, move_z: Float) -> (Int, Int) {
        var (return_row, return_col) = (row, col)
        
        // set of valid knight moves from current spot (key = row value : value = col value)
        var moves = [Int: [Int]]()
        moves[row - 2] = [col - 1, col + 1]
        moves[row + 2] = [col - 1, col + 1]
        moves[row - 1] = [col - 2, col + 2]
        moves[row + 1] = [col - 2, col + 2]
        
        return_row = moved_up_down(row: row, move_z: move_z)
        return_col = moved_left_right(col: col, move_x: move_x)
        
        var moveExists = false
        if let cols = moves[return_row] {
            moveExists = cols.contains(return_col)
        }
        
        if moveExists {
            return (return_row, return_col)
        }
        
        return (row, col)
    }
    
    // King moves
    static func moveKing(row: Int, col: Int, move_x: Float, move_z: Float) -> (Int, Int) {
        var (return_row, return_col) = (row, col)
        
        // valid moves (key = row : value = col)
        var moves = [Int: [Int]]()
        moves[row - 1] = [col - 1, col, col + 1]
        moves[row] = [col - 1, col + 1]
        moves[row + 1] = [col - 1, col, col + 1]
        
        return_row = moved_up_down(row: row, move_z: move_z)
        return_col = moved_left_right(col: col, move_x: move_x)
        
        var moveExists = false
        if let cols = moves[return_row] {
            moveExists = cols.contains(return_col)
        }
        
        if moveExists {
            return (return_row, return_col)
        }
        
        return (row, col)
    }
    
    // Queen moves
    static func moveQueen(row: Int, col: Int, move_x: Float, move_z: Float) -> (Int, Int) {
        var (return_row, return_col) = (row, col)
        
        // moves like a rook, bishop, and king combined
        // valid king moves (key = row : value = col)
        var moves = [Int: [Int]]()
        moves[row - 1] = [col - 1, col, col + 1]
        moves[row] = [col - 1, col + 1]
        moves[row + 1] = [col - 1, col, col + 1]
        
        return_row = moved_up_down(row: row, move_z: move_z)
        return_col = moved_left_right(col: col, move_x: move_x)
        
        // check king moves
        var moveExists = false
        if let cols = moves[return_row] {
            moveExists = cols.contains(return_col)
        }
        
        if moveExists {
            return (return_row, return_col)
        }
        
        // check bishop moves
        let row_diff = abs(return_row - row)
        let col_diff = abs(return_col - col)
        if row_diff == col_diff {
            return (return_row, return_col)
        }
        
        // check rook moves
        if return_row != row {
            return_col = col
        } else if return_col != col {
            return_row = row
        }
        
        return (return_row, return_col)
        
    }
    
    
    // gives the number of rows moved up / down. from -7 to 7
    static func moved_up_down(row: Int, move_z: Float) -> Int {
        var return_row = row
        
        if move_z <= -1.3 {
            return_row -= 7
        } else if move_z <= -1.1 {
            return_row -= 6
        } else if move_z <= -0.9 {
            return_row -= 5
        } else if move_z <= -0.7 {
            return_row -= 4
        } else if move_z <= -0.5 {
            return_row -= 3
        } else if move_z <= -0.3 {
            return_row -= 2
        } else if move_z <= -0.1 {
            return_row -= 1
        } else if move_z >= 1.3 {
            return_row += 7
        } else if move_z >= 1.1 {
            return_row += 6
        } else if move_z >= 0.9 {
            return_row += 5
        } else if move_z >= 0.7 {
            return_row += 4
        } else if move_z >= 0.5 {
            return_row += 3
        } else if move_z >= 0.3 {
            return_row += 2
        } else if move_z >= 0.1 {
            return_row += 1
        }
        
        // boundary checks
        if return_row < 0 {
            return_row = 0
        } else if return_row > 7 {
            return_row = 7
        }
        
        return return_row
    }
    
    // gives the number of cols moved left / right. from -7 to 7/
    static func moved_left_right(col: Int, move_x: Float) -> Int {
        var return_col = col
        
        if move_x >= 1.3 {
            return_col += 7
        } else if move_x >= 1.1 {
            return_col += 6
        } else if move_x >= 0.9 {
            return_col += 5
        } else if move_x >= 0.7 {
            return_col += 4
        } else if move_x >= 0.5 {
            return_col += 3
        } else if move_x >= 0.3 {
            return_col += 2
        } else if move_x >= 0.1 {
            return_col += 1
        } else if move_x <= -1.3 {
            return_col -= 7
        } else if move_x <= -1.1 {
            return_col -= 6
        } else if move_x <= -0.9 {
            return_col -= 5
        } else if move_x <= -0.7 {
            return_col -= 4
        } else if move_x <= -0.5 {
            return_col -= 3
        } else if move_x <= -0.3 {
            return_col -= 2
        } else if move_x <= -0.1 {
            return_col -= 1
        }
        
        if return_col < 0 {
            return_col = 0
        } else if return_col > 7 {
            return_col = 7
        }
        
        return return_col
    }
    
    // give chess board in Forsyth-Edwards notation
    static func serializeBoard(squares: [[ModelEntity]]) -> String {
        var ret = ""
        var empties = 0
        var pieceMappings: [String: String] = [
            // opponent mappings
            "Opponent_King": "k",
            "Opponent_Queen": "q",
            "Opponent_Rook": "r",
            "Opponent_Bishop": "b",
            "Opponent_Knight": "n",
            "Opponent_Pawn": "p",
            // my mappings
            "King": "K",
            "Queen": "Q",
            "Rook": "R",
            "Bishop": "B",
            "Knight": "N",
            "Pawn": "P"
        ]
        
        for row in 0..<8 {
            // separate rows
            if row != 0 {
                ret += "/"
            }
            for col in 0..<8 {
                
                // if nothing placed on square, add to running count of consecutive empty squares
                if squares[row][col].children.count == 0 {
                    empties += 1
                }
                // if square has something on it, first add empty spots leading up to it then add the piece
                else if squares[row][col].children.count > 0 {
                    let piece_name = squares[row][col].children[0].name
                    if empties > 0 {
                        ret += String(empties)
                        empties = 0
                    }
                    ret += pieceMappings[piece_name]!
                }
                // make sure to add the remaining empties to current column before moving on
                if col == 7 {
                    if empties > 0 {
                        ret += String(empties)
                        empties = 0
                    }
                }
            }
        }
        
        
        return ret
    }
    
}
