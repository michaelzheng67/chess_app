//
//  CreatePieces.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-21.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

extension UIColor {
    func adjustedBrightness(by factor: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            // Adjust brightness
            return UIColor(red: max(red - factor, 0.0),
                           green: max(green - factor, 0.0),
                           blue: max(blue - factor, 0.0),
                           alpha: alpha)
        } else {
            // Return the original color if unable to decompose
            return self
        }
    }
}


struct CreatePieces {
    static var opp_colour: UIColor = .black
    static var opp_pawn: UIColor = .black
    static var opp_rook: UIColor = .lightGray
    
    static var pawn: UIColor = .gray
    static var rook: UIColor = .white
    static var bishop: UIColor = .blue
    static var knight: UIColor = .green
    static var king: UIColor = .systemYellow
    static var queen: UIColor = .systemPink
    
    
    // opp = whether opponent or user piece
    static func generatePawn(opp: Bool) -> ModelEntity {
        let pawnColor = opp ? pawn.adjustedBrightness(by: 0.4) : pawn
        let metallic = opp ? false : true
        let ret = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: pawnColor, isMetallic: metallic)]
                )
        ret.components.set(GroundingShadowComponent(castsShadow: true))
        
        if opp {
            ret.name = "Opponent_Pawn"
        } else {
            ret.name = "Pawn"
        }
        return ret
    }
    
    static func generateRook(opp: Bool) -> ModelEntity {
        let rookColor = opp ? rook.adjustedBrightness(by: 0.4) : rook
        let metallic = opp ? false : true
        let ret = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: rookColor, isMetallic: metallic)]
                )
        ret.components.set(GroundingShadowComponent(castsShadow: true))
        
        if opp {
            ret.name = "Opponent_Rook"
        } else {
            ret.name = "Rook"
        }
        return ret
    }
    
    static func generateBishop(opp: Bool) -> ModelEntity {
        let bishopColor = opp ? bishop.adjustedBrightness(by: 0.4) : bishop
        let metallic = opp ? false : true
        let ret = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: bishopColor, isMetallic: metallic)]
                )
        ret.components.set(GroundingShadowComponent(castsShadow: true))
        
        if opp {
            ret.name = "Opponent_Bishop"
        } else {
            ret.name = "Bishop"
        }
        return ret
    }
    
    static func generateKnight(opp: Bool) -> ModelEntity {
        let knightColor = opp ? knight.adjustedBrightness(by: 0.4) : knight
        let metallic = opp ? false : true
        let ret = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: knightColor, isMetallic: metallic)]
                )
        ret.components.set(GroundingShadowComponent(castsShadow: true))
        
        if opp {
            ret.name = "Opponent_Knight"
        } else {
            ret.name = "Knight"
        }
        return ret
    }
    
    static func generateKing(opp: Bool) -> ModelEntity {
        let kingColor = opp ? king.adjustedBrightness(by: 0.4) : king
        let metallic = opp ? false : true
        let ret = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: kingColor, isMetallic: metallic)]
                )
        ret.components.set(GroundingShadowComponent(castsShadow: true))
        
        if opp {
            ret.name = "Opponent_King"
        } else {
            ret.name = "King"
        }
        return ret
    }
    
    static func generateQueen(opp: Bool) -> ModelEntity {
        let queenColor = opp ? queen.adjustedBrightness(by: 0.4) : queen
        let metallic = opp ? false : true
        let ret = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: queenColor, isMetallic: metallic)]
                )
        ret.components.set(GroundingShadowComponent(castsShadow: true))
        
        if opp {
            ret.name = "Opponent_Queen"
        } else {
            ret.name = "Queen"
        }
        return ret
    }
}
