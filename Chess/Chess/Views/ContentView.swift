//
//  ContentView.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-03.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var showSoloGame = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    Text("Chess Game ♟️")
                        .font(.extraLargeTitle)
                    
                    Toggle("Solo Game", isOn: $showSoloGame)
                        .toggleStyle(.button)
                        .padding(.top, 50)
                    
                    Toggle("Play With Friends", isOn: $showImmersiveSpace)
                        .toggleStyle(.button)
                        .padding(.top, 25)
                }
            }
            .navigationDestination(isPresented: $showSoloGame) {
                Solo()
            }
            .padding()
    //        .onChange(of: showImmersiveSpace) { _, newValue in
    //            Task {
    //                if newValue {
    //                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
    //                    case .opened:
    //                        immersiveSpaceIsShown = true
    //                    case .error, .userCancelled:
    //                        fallthrough
    //                    @unknown default:
    //                        immersiveSpaceIsShown = false
    //                        showImmersiveSpace = false
    //                    }
    //                } else if immersiveSpaceIsShown {
    //                    await dismissImmersiveSpace()
    //                    immersiveSpaceIsShown = false
    //                }
    //            }
    //        }
        }
        
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
