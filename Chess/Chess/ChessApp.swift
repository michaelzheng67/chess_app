//
//  ChessApp.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-03.
//

import SwiftUI

@main
struct ChessApp: App {
    @State private var dataModel = DataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataModel)
        }.windowStyle(.automatic)
            .defaultSize(width: 800, height: 800)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environment(dataModel)
        }.windowStyle(.volumetric)
    }
}
