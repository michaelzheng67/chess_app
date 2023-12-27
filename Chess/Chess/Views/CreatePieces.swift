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
    static func generatePawn(opp: Bool) -> Entity? {
//        let pawnColor = opp ? pawn.adjustedBrightness(by: 0.4) : pawn
//        let metallic = opp ? false : true
//        let ret = ModelEntity(
//                    mesh: .generateSphere(radius: 0.025),
//                    materials: [SimpleMaterial(color: pawnColor, isMetallic: metallic)]
//                )
        

        do {
            if opp {
                let ret = try Entity.load(named: "Pawn_black", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            } else {
                let ret = try Entity.load(named: "Pawn_white", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            }
        } catch {
            print("error loading pawn")
        }
        
        return nil
    }
    
    static func generateRook(opp: Bool) -> Entity? {
//        let rookColor = opp ? rook.adjustedBrightness(by: 0.4) : rook
//        let metallic = opp ? false : true
//        let ret = ModelEntity(
//                    mesh: .generateSphere(radius: 0.025),
//                    materials: [SimpleMaterial(color: rookColor, isMetallic: metallic)]
//                )
//        ret.components.set(GroundingShadowComponent(castsShadow: true))
//        
//        if opp {
//            ret.name = "Opponent_Rook"
//        } else {
//            ret.name = "Rook"
//        }
//        return ret
        
        do {
            if opp {
                let ret = try Entity.load(named: "Rook_black", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            } else {
                let ret = try Entity.load(named: "Rook_white", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            }
        } catch {
            print("error loading rook")
        }
        
        return nil
    }
    
    static func generateBishop(opp: Bool) -> Entity? {
//        let bishopColor = opp ? bishop.adjustedBrightness(by: 0.4) : bishop
//        let metallic = opp ? false : true
//        let ret = ModelEntity(
//                    mesh: .generateSphere(radius: 0.025),
//                    materials: [SimpleMaterial(color: bishopColor, isMetallic: metallic)]
//                )
//        ret.components.set(GroundingShadowComponent(castsShadow: true))
//        
//        if opp {
//            ret.name = "Opponent_Bishop"
//        } else {
//            ret.name = "Bishop"
//        }
//        return ret
        
        do {
            if opp {
                let ret = try Entity.load(named: "Bishop_black", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            } else {
                let ret = try Entity.load(named: "Bishop_white", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            }
        } catch {
            print("error loading bishop")
        }
        
        return nil
    }
    
    static func generateKnight(opp: Bool) -> Entity? {
//        let knightColor = opp ? knight.adjustedBrightness(by: 0.4) : knight
//        let metallic = opp ? false : true
//        let ret = ModelEntity(
//                    mesh: .generateSphere(radius: 0.025),
//                    materials: [SimpleMaterial(color: knightColor, isMetallic: metallic)]
//                )
//        ret.components.set(GroundingShadowComponent(castsShadow: true))
//        
//        if opp {
//            ret.name = "Opponent_Knight"
//        } else {
//            ret.name = "Knight"
//        }
//        return ret
        
        do {
            if opp {
                let ret = try Entity.load(named: "Knight_black", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            } else {
                let ret = try Entity.load(named: "Knight_white", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            }
        } catch {
            print("error loading knight")
        }
        
        return nil
    }
    
    static func generateKing(opp: Bool) -> Entity? {
//        let kingColor = opp ? king.adjustedBrightness(by: 0.4) : king
//        let metallic = opp ? false : true
//        let ret = ModelEntity(
//                    mesh: .generateSphere(radius: 0.025),
//                    materials: [SimpleMaterial(color: kingColor, isMetallic: metallic)]
//                )
//        ret.components.set(GroundingShadowComponent(castsShadow: true))
//        
//        if opp {
//            ret.name = "Opponent_King"
//        } else {
//            ret.name = "King"
//        }
//        return ret
        
        do {
            if opp {
                let ret = try Entity.load(named: "King_black", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            } else {
                let ret = try Entity.load(named: "King_white", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            }
        } catch {
            print("error loading pawn")
        }
        
        return nil
    }
    
    static func generateQueen(opp: Bool) -> Entity? {
//        let queenColor = opp ? queen.adjustedBrightness(by: 0.4) : queen
//        let metallic = opp ? false : true
//        let ret = ModelEntity(
//                    mesh: .generateSphere(radius: 0.025),
//                    materials: [SimpleMaterial(color: queenColor, isMetallic: metallic)]
//                )
//        ret.components.set(GroundingShadowComponent(castsShadow: true))
//        
//        if opp {
//            ret.name = "Opponent_Queen"
//        } else {
//            ret.name = "Queen"
//        }
//        return ret
        
        do {
            if opp {
                let ret = try Entity.load(named: "Queen_black", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            } else {
                let ret = try Entity.load(named: "Queen_white", in: RealityKitContent.realityKitContentBundle)
                ret.components.set(GroundingShadowComponent(castsShadow: true))
                return ret
            }
        } catch {
            print("error loading queen")
        }
        
        return nil
    }
}
