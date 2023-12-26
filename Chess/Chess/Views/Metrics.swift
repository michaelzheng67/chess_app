//
//  Metrics.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-24.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

struct Metrics : View {
    
    @Environment(DataModel.self) var dataModel
    
    var body : some View {
        VStack {
            Text("Game Stats")
                .font(.extraLargeTitle)
            Text("Turns: " + String(dataModel.turn))
                .font(.largeTitle)
            
            if dataModel.isTimed == true {
                Text("Player Time (seconds): " + String(dataModel.playerClock))
                    .font(.largeTitle)
                Text("Bot Time (seconds): " + String(dataModel.botClock))
                    .font(.largeTitle)
            }
        }
    }
}
