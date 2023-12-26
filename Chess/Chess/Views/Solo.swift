//
//  Solo.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-03.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

struct Solo: View {
    
    @State private var selectedDifficulty: String?
    let difficulty = ["Easy", "Medium", "Hard"]
    
    @State private var selectedTimer: String?
    let timer = ["Untimed", "Timed"]
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var canStart = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(DataModel.self) var dataModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 70) {
                Text("Solo Game vs. Bot")
                    .font(.extraLargeTitle)
                
                // select difficulty
                HStack{
                    Spacer()
                    HStack {
                        ForEach(difficulty, id: \.self) { option in
                            Button(action: {
                                self.selectedDifficulty = option
                                
                                if option == "Easy" {
                                    dataModel.botLevel = 1
                                } else if option == "Medium" {
                                    dataModel.botLevel = 2
                                } else if option == "Hard" {
                                    dataModel.botLevel = 3
                                }
                                
                                                                
                            }) {
                                Text(option)
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 30) // Adjust width and height as needed
                                    .background(selectedDifficulty == option ? Color.gray.opacity(0.7) : Color.clear)
                                    .cornerRadius(10)
                            }
                            .padding(1) // Smaller padding
                            .buttonStyle(PlainButtonStyle()) // Remove button styling
                        }
                    }
                    Spacer()
                }
                
                // select timed vs. untimed
                HStack {
                    Spacer()
                    HStack {
                        ForEach(timer, id: \.self) { option in
                            Button(action: {
                                self.selectedTimer = option
                            }) {
                                
                                Text(option)
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 30)
                                    .background(selectedTimer == option ? Color.gray.opacity(0.7) : Color.clear)
                                    .cornerRadius(10)
                            }
                            .padding(1)
                            .buttonStyle(PlainButtonStyle()) // Remove button styling
                        }
                    }
                    Spacer()
                }
                
                Toggle("Start", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 25)
                    .disabled(!canStart)
                
                
                
            }
            .onChange(of: showImmersiveSpace) { _, newValue in
                Task {
                    if newValue {
                        switch await openImmersiveSpace(id: "ImmersiveSpace") {
                        case .opened:
                            immersiveSpaceIsShown = true
                        case .error, .userCancelled:
                            fallthrough
                        @unknown default:
                            immersiveSpaceIsShown = false
                            showImmersiveSpace = false
                        }
                    } else if immersiveSpaceIsShown {
                        await dismissImmersiveSpace()
                        immersiveSpaceIsShown = false
                    }
                }
            }
            // check if both difficulty and timer buttons were selected
            .onChange(of: selectedDifficulty) {
                if selectedDifficulty != nil && selectedTimer != nil {
                    if selectedTimer == "Timed" {
                        dataModel.isTimed = true
                    }
                    canStart = true
                }
            }
            .onChange(of: selectedTimer) {
                if selectedDifficulty != nil && selectedTimer != nil {
                    if selectedTimer == "Timed" {
                        dataModel.isTimed = true
                    }
                    canStart = true
                }
            }
        }
        .navigationDestination(isPresented: $showImmersiveSpace) {
            Metrics()
        }
    }
}
