//
//  ImmersiveView.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-03.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @State private var squares: [[ModelEntity]] = [[]] // global state of chessboard squares
    @State private var highlighted: [(square: ModelEntity, row: Int, col: Int)] = [] // keep track of which square is being highlighted while moving piece
    @State private var square_size: Float = 0.2 // size of chessboard square
    @Environment(DataModel.self) var dataModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        RealityView { content in
            // Add a chessboard
            let (chessboard, squares) = createChessboard()
            
            self.squares = squares
            let anchor = AnchorEntity(.head)
            
            content.add(chessboard)
            content.add(anchor)
            let anchorEntity = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2(repeating: 0)))
            
            content.add(anchorEntity)
            
            chessboard.position = [-0.6, 0, -2.4]
        
//            var environment = nil
//            try {
//                environment = EnvironmentResource(named: "studio") // adding overhead lighting
//            }
            
            
        
            // fill up opponent pieces
            for row in 1..<2 {
                for col in 0..<8 {
                    let modelCopy = CreatePieces.generatePawn(opp: true)
                    placeEntityOnSquare(entity: modelCopy, row: row, column: col)
                    modelCopy.position = [0, 0.025, 0]
                    modelCopy.generateCollisionShapes(recursive: false)
                    modelCopy.components.set(GroundingShadowComponent(castsShadow: true))
                    modelCopy.name = "Opponent_Pawn"
//                    if environment != nil {
//                        modelCopy.components.set(ImageBasedLightComponent(source: .single(environment)))
//                        modelCopy.components.set(ImageBasedLightReceiverComponent(imageBasedLight: modelCopy))
//                    }
                }
            }
            
            let Opp_Rook1 = CreatePieces.generateRook(opp: true)

            placeEntityOnSquare(entity: Opp_Rook1, row: 0, column: 0)
            Opp_Rook1.position = [0, 0.025, 0]
            Opp_Rook1.generateCollisionShapes(recursive: false)
            Opp_Rook1.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Rook1.name = "Opponent_Rook"
            
            let Opp_Rook2 = CreatePieces.generateRook(opp: true)

            placeEntityOnSquare(entity: Opp_Rook2, row: 0, column: 7)
            Opp_Rook2.position = [0, 0.025, 0]
            Opp_Rook2.generateCollisionShapes(recursive: false)
            Opp_Rook2.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Rook2.name = "Opponent_Rook"
            
            let Opp_Bishop1 = CreatePieces.generateBishop(opp: true)

            placeEntityOnSquare(entity: Opp_Bishop1, row: 0, column: 2)
            Opp_Bishop1.position = [0, 0.025, 0]
            Opp_Bishop1.generateCollisionShapes(recursive: false)
            Opp_Bishop1.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Bishop1.name = "Opponent_Bishop"
            
            let Opp_Bishop2 = CreatePieces.generateBishop(opp: true)

            placeEntityOnSquare(entity: Opp_Bishop2, row: 0, column: 5)
            Opp_Bishop2.position = [0, 0.025, 0]
            Opp_Bishop2.generateCollisionShapes(recursive: false)
            Opp_Bishop2.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Bishop2.name = "Opponent_Bishop"
            
            let Opp_Knight1 = CreatePieces.generateKnight(opp: true)

            placeEntityOnSquare(entity: Opp_Knight1, row: 0, column: 1)
            Opp_Knight1.position = [0, 0.025, 0]
            Opp_Knight1.generateCollisionShapes(recursive: false)
            Opp_Knight1.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Knight1.name = "Opponent_Knight"
            
            let Opp_Knight2 = CreatePieces.generateKnight(opp: true)

            placeEntityOnSquare(entity: Opp_Knight2, row: 0, column: 6)
            Opp_Knight2.position = [0, 0.025, 0]
            Opp_Knight2.generateCollisionShapes(recursive: false)
            Opp_Knight2.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Knight2.name = "Opponent_Knight"
            
            let Opp_King = CreatePieces.generateKing(opp: true)

            placeEntityOnSquare(entity: Opp_King, row: 0, column: 4)
            Opp_King.position = [0, 0.025, 0]
            Opp_King.generateCollisionShapes(recursive: false)
            Opp_King.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_King.name = "Opponent_King"
            
            let Opp_Queen = CreatePieces.generateQueen(opp: true)

            placeEntityOnSquare(entity: Opp_Queen, row: 0, column: 3)
            Opp_Queen.position = [0, 0.025, 0]
            Opp_Queen.generateCollisionShapes(recursive: false)
            Opp_Queen.components.set(GroundingShadowComponent(castsShadow: true))
            Opp_Queen.name = "Opponent_Queen"
            
            // fill up player pieces
            for row in 6..<7 {
                for col in 0..<8 {
                    let modelCopy = ModelEntity(
                                mesh: .generateSphere(radius: 0.025),
                                materials: [SimpleMaterial(color: .gray, isMetallic: true)]
                            )

                    placeEntityOnSquare(entity: modelCopy, row: row, column: col)
                    modelCopy.position = [0, 0.025, 0]
                    modelCopy.generateCollisionShapes(recursive: false)
                    modelCopy.components.set(GroundingShadowComponent(castsShadow: true))
                    modelCopy.components.set(InputTargetComponent())
                    modelCopy.name = "Pawn"
                }
            }
            
            let Rook1 = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .white, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Rook1, row: 7, column: 0)
            Rook1.position = [0, 0.025, 0]
            Rook1.generateCollisionShapes(recursive: false)
            Rook1.components.set(GroundingShadowComponent(castsShadow: true))
            Rook1.components.set(InputTargetComponent())
            Rook1.name = "Rook"
            
            let Rook2 = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .white, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Rook2, row: 7, column: 7)
            Rook2.position = [0, 0.025, 0]
            Rook2.generateCollisionShapes(recursive: false)
            Rook2.components.set(GroundingShadowComponent(castsShadow: true))
            Rook2.components.set(InputTargetComponent())
            Rook2.name = "Rook"
            
            let Bishop1 = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .blue, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Bishop1, row: 7, column: 2)
            Bishop1.position = [0, 0.025, 0]
            Bishop1.generateCollisionShapes(recursive: false)
            Bishop1.components.set(GroundingShadowComponent(castsShadow: true))
            Bishop1.components.set(InputTargetComponent())
            Bishop1.name = "Bishop"
            
            let Bishop2 = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .blue, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Bishop2, row: 7, column: 5)
            Bishop2.position = [0, 0.025, 0]
            Bishop2.generateCollisionShapes(recursive: false)
            Bishop2.components.set(GroundingShadowComponent(castsShadow: true))
            Bishop2.components.set(InputTargetComponent())
            Bishop2.name = "Bishop"
            
            let Knight1 = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .green, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Knight1, row: 7, column: 1)
            Knight1.position = [0, 0.025, 0]
            Knight1.generateCollisionShapes(recursive: false)
            Knight1.components.set(GroundingShadowComponent(castsShadow: true))
            Knight1.components.set(InputTargetComponent())
            Knight1.name = "Knight"
            
            let Knight2 = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .green, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Knight2, row: 7, column: 6)
            Knight2.position = [0, 0.025, 0]
            Knight2.generateCollisionShapes(recursive: false)
            Knight2.components.set(GroundingShadowComponent(castsShadow: true))
            Knight2.components.set(InputTargetComponent())
            Knight2.name = "Knight"
            
            let King = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .systemYellow, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: King, row: 7, column: 4)
            King.position = [0, 0.025, 0]
            King.generateCollisionShapes(recursive: false)
            King.components.set(GroundingShadowComponent(castsShadow: true))
            King.components.set(InputTargetComponent())
            King.name = "King"
            
            let Queen = ModelEntity(
                        mesh: .generateSphere(radius: 0.025),
                        materials: [SimpleMaterial(color: .systemPink, isMetallic: true)]
                    )

            placeEntityOnSquare(entity: Queen, row: 7, column: 3)
            Queen.position = [0, 0.025, 0]
            Queen.generateCollisionShapes(recursive: false)
            Queen.components.set(GroundingShadowComponent(castsShadow: true))
            Queen.components.set(InputTargetComponent())
            Queen.name = "Queen"
        }
        .gesture(DragGesture(minimumDistance: 0)
            .targetedToAnyEntity()
            .onChanged { value in
                // only let moves when its user's turn
                if dataModel.playerTurn == 0 {
                    value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                    value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    
                    // get starting coordinates
                    var start_x = value.entity.parent!.position[0]
                    var start_z = value.entity.parent!.position[2]
                    
                    // to fix rounding errors
                    if start_z <= 0.4 && start_z >= 0.2 {
                        start_z = 0.4
                    } else if start_z <= 0.2 && start_z > 0.0 {
                        start_z = 0.2
                    }
                    
                    if start_x <= 0.2 && start_x > 0.0 {
                        start_x = 0.2
                    }
                    
                    let start_row = Int(start_z / self.square_size)
                    let start_col = Int(start_x / self.square_size)
                    
                    // if there was a previous square highlighted from moving, we stop highlighting it
                    if !self.highlighted.isEmpty {
                        let (square, row, col) = self.highlighted.popLast()!
                        
                        let color: UIColor = (row + col) % 2 == 0 ? .white : .black
                        square.model?.materials = [SimpleMaterial(color: color, isMetallic: false)]
                    }
                    
                    var (row, col) = (0, 0)
                    
                    if value.entity.name == "Pawn" {
                        (row, col) = ChessMoves.movePawn(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Rook" {
                        (row, col) = ChessMoves.moveRook(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Bishop" {
                        (row, col) = ChessMoves.moveBishop(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Knight" {
                        (row, col) = ChessMoves.moveKnight(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "King" {
                        (row, col) = ChessMoves.moveKing(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Queen" {
                        (row, col) = ChessMoves.moveQueen(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    }
                    
                    // knights don't need to worry about not being able to get to a spot
                    if value.entity.name != "Knight" {
                        (row, col) = obstacleDetection(start_row: start_row, start_col: start_col, end_row: row, end_col: col)
                    }
                    self.squares[row][col].model?.materials = [SimpleMaterial(color: .blue, isMetallic: false)]
                    
                    self.highlighted.append((square: self.squares[row][col], row: row, col: col))
                }
       
                
            }
            .onEnded { value in
                // only let moves when user's turn
                if dataModel.playerTurn == 0 {
                    dataModel.placedPieceSound()
                    
                    value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
                    
                    // get starting coordinates
                    var start_x = value.entity.parent!.position[0]
                    var start_z = value.entity.parent!.position[2]
                    
                    // to fix rounding errors
                    if start_z <= 0.4 && start_z >= 0.2 {
                        start_z = 0.4
                    } else if start_z <= 0.2 && start_z > 0.0 {
                        start_z = 0.2
                    }
                    
                    if start_x <= 0.2 && start_x > 0.0 {
                        start_x = 0.2
                    }
                    
                    let start_row = Int(start_z / self.square_size)
                    let start_col = Int(start_x / self.square_size)
                    
                    print("START_COL = " + String(start_x))
                    
                    
                    // if there was a previous square highlighted from moving, we stop highlighting it
                    if !self.highlighted.isEmpty {
                        let (square, row, col) = self.highlighted.popLast()!
                        
                        let color: UIColor = (row + col) % 2 == 0 ? .white : .black
                        square.model?.materials = [SimpleMaterial(color: color, isMetallic: false)]
                    }
                    
                    var (row, col) = (0, 0)
                    
                    if value.entity.name == "Pawn" {
                        (row, col) = ChessMoves.movePawn(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Rook" {
                        (row, col) = ChessMoves.moveRook(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Bishop" {
                        (row, col) = ChessMoves.moveBishop(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Knight" {
                        (row, col) = ChessMoves.moveKnight(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "King" {
                        (row, col) = ChessMoves.moveKing(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    } else if value.entity.name == "Queen" {
                        (row, col) = ChessMoves.moveQueen(row: start_row, col: start_col, move_x:value.entity.position[0], move_z:value.entity.position[2])
                    }
                    
                    // knights don't need to worry about not being able to get to a spot
                    if value.entity.name != "Knight" {
                        (row, col) = obstacleDetection(start_row: start_row, start_col: start_col, end_row: row, end_col: col)
                    }
                    captureDetection(row: row, col: col)
                    placeMovedEntityOnSquare(entity: value.entity, row: row, column: col)
                    value.entity.position = [0, 0.025, 0]
                    
                    // send board state to server only if actual move (account for edge case where user picks up piece but doesn't place it somewhere else)
                    if (start_row, start_col) != (row, col) {
                        let representation = ChessMoves.serializeBoard(squares: self.squares)
                        print("posted = " + representation)
                        NetworkUtils.postBoard(board: representation, difficulty: dataModel.botLevel)
                        dataModel.playerTurn = 1
                    }
                }

            })
        .onChange(of: dataModel.playerTurn) {
            if dataModel.playerTurn == 1 {
                Task {
                    do {
                        let dataString = try await NetworkUtils.getBoard(board: "")
                        DispatchQueue.main.async {
                                   updateBoard(board_str: dataString)
                                   dataModel.botCompleted = 1
                                   print("get = " + dataString)
                               }
                    } catch {
                        print("Error fetching data: \(error)")
                    }
                }
            }
        }
        .onChange(of: dataModel.botCompleted) {
            if dataModel.botCompleted == 1 {
                dataModel.placedPieceSound()
                dataModel.playerTurn = 0
                dataModel.botCompleted = 0
                dataModel.turn += 1 // since player starts, each time bot is done signals end of a turn
            }
        }
        .onReceive(timer) { _ in
            if dataModel.playerTurn == 0 {
                dataModel.playerClock += 1
            } else {
                dataModel.botClock += 1
            }
        }
                
    }
    

    // Function to create a chessboard
    func createChessboard() -> (Entity, [[ModelEntity]]) {
        let board = Entity()
        var squares = [[ModelEntity]]()

        let rows = 8
        let columns = 8

        for row in 0..<rows {
            var rowSquares = [ModelEntity]()
            for column in 0..<columns {
                let color: UIColor = (row + column) % 2 == 0 ? .white : .black
                let square = createSquare(size: self.square_size, color: color)
                square.position = [Float(column) * self.square_size, 0, Float(row) * self.square_size]
                board.addChild(square)
                square.setParent(board)
                rowSquares.append(square)
            }
            squares.append(rowSquares)
        }

        return (board, squares)
    }

    // Function to create a single square
    func createSquare(size: Float, color: UIColor) -> ModelEntity {
        let square = ModelEntity(mesh: .generatePlane(width: size, depth: size), materials: [SimpleMaterial(color: color, isMetallic: false)])
        square.generateCollisionShapes(recursive: false)
        square.components[PhysicsBodyComponent.self] = .init(
            massProperties: .default,
            mode: .static
        )
        return square
    }
    
    func placeEntityOnSquare(entity: ModelEntity, row: Int, column: Int) {
        let halfSquareSize = self.square_size / 2

        let targetSquare = self.squares[row][column]
        // Adjust the position to be at the center of the square
        entity.position = [targetSquare.position.x + halfSquareSize, targetSquare.position.y, targetSquare.position.z + halfSquareSize]
        targetSquare.addChild(entity)
        entity.setParent(targetSquare)
    }
    
    func placeMovedEntityOnSquare(entity: Entity, row: Int, column: Int) {
        let halfSquareSize = self.square_size / 2

        let targetSquare = self.squares[row][column]
        // Adjust the position to be at the center of the square
        entity.position = [targetSquare.position.x + halfSquareSize, targetSquare.position.y, targetSquare.position.z + halfSquareSize]
        targetSquare.addChild(entity)
        entity.setParent(targetSquare)
    }
    
    // updates board given string in Forsyth-Edwards form
    func updateBoard(board_str: String) {
        // split string into arrays
        let splitArray = board_str.components(separatedBy: "/")
        let nums: [Character: Int] = ["1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8]
        
        // clear board first
        for row in 0..<8 {
            for col in 0..<8 {
                if self.squares[row][col].children.count > 0 {
                    self.squares[row][col].removeChild(self.squares[row][col].children[0])
                }
            }
        }
        for i in 0..<8 {
            let currArray = splitArray[i]
            var j = 0 // keeps track of board position
            var str_idx = 0 // keep track of position in string
            for str_idx in 0..<currArray.count {
                let index = currArray.index(currArray.startIndex, offsetBy: str_idx)
                let character = currArray[index]
                // if current character is actually a number
                if nums.keys.contains(character) {
                    j += Int(String(character))!
                }
                // otherwise a chess piece, so place it in correct spot
                else {
                    switch character {
                    case "K":
                        let model = CreatePieces.generateKing(opp: false)
                        model.name = "King"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                        model.components.set(InputTargetComponent())
                    case "Q":
                        let model = CreatePieces.generateQueen(opp: false)
                        model.name = "Queen"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                        model.components.set(InputTargetComponent())
                    case "R":
                        let model = CreatePieces.generateRook(opp: false)
                        model.name = "Rook"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                        model.components.set(InputTargetComponent())
                    case "B":
                        let model = CreatePieces.generateBishop(opp: false)
                        model.name = "Bishop"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                        model.components.set(InputTargetComponent())
                    case "N":
                        let model = CreatePieces.generateKnight(opp: false)
                        model.name = "Knight"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                        model.components.set(InputTargetComponent())
                    case "P":
                        let model = CreatePieces.generatePawn(opp: false)
                        model.name = "Pawn"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                        model.components.set(InputTargetComponent())
                    case "k":
                        let model = CreatePieces.generateKing(opp: true)
                        model.name = "Opponent_King"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                    case "q":
                        let model = CreatePieces.generateQueen(opp: true)
                        model.name = "Opponent_Queen"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                    case "r":
                        let model = CreatePieces.generateRook(opp: true)
                        model.name = "Opponent_Rook"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                    case "b":
                        let model = CreatePieces.generateBishop(opp: true)
                        model.name = "Opponent_Bishop"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                    case "n":
                        let model = CreatePieces.generateKnight(opp: true)
                        model.name = "Opponent_Knight"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                    case "p":
                        let model = CreatePieces.generatePawn(opp: true)
                        model.name = "Opponent_Pawn"
                        placeEntityOnSquare(entity: model, row: i, column: j)
                        model.position = [0, 0.025, 0]
                        model.generateCollisionShapes(recursive: false)
                    default:
                        break
                    }
                    j += 1
                }
            }
        }
    }
    
    // detect if we have captured an opponent piece
    func captureDetection(row: Int, col: Int) {
        
        // see if we have an opponent piece at the given row and col as well
        let square = self.squares[row][col]
        
        // check if opponent placed on square first
        var firstPiece = "None"
        if square.children.count > 0 {
            firstPiece = square.children[0].name
        }
        
        // opponent pieces
        let OppPieces: Set<String> = ["Opponent_King",
                                      "Opponent_Queen",
                                      "Opponent_Rook",
                                      "Opponent_Bishop",
                                      "Opponent_Knight",
                                      "Opponent_Pawn"]
        
        if OppPieces.contains(firstPiece) {
            square.children[0].removeFromParent()
        }
    }
    
    // detect if object blocking movement path. If we can move to spot, we return it. If not, we return closest to spot we want to go
    // considering obstacles
    func obstacleDetection(start_row: Int, start_col: Int, end_row: Int, end_col: Int) -> (Int, Int) {
        var (return_row, return_col) = (start_row, start_col)
        
        // +1 -> going down / right, -1 -> going up / left
        var row_direction = 0
        var col_direction = 0
        
        let row_diff = end_row - start_row
        let col_diff = end_col - start_col
        
        if row_diff < 0 {
            row_direction = -1
        } else if row_diff > 0 {
            row_direction = 1
        }
        
        if col_diff < 0 {
            col_direction = -1
        } else if col_diff > 0 {
            col_direction = 1
        }
        
        // opponent pieces
        let OppPieces: Set<String> = ["Opponent_King",
                                      "Opponent_Queen",
                                      "Opponent_Rook",
                                      "Opponent_Bishop",
                                      "Opponent_Knight",
                                      "Opponent_Pawn"]
        
        // see if the next spot is already occupied
        while return_row != end_row || return_col != end_col {
            let next_spot = self.squares[return_row + row_direction][return_col + col_direction]
            if next_spot.children.count > 0 {
                // if opponent occupies next spot, we take it
                if OppPieces.contains(next_spot.children[0].name) {
                    return (return_row + row_direction, return_col + col_direction)
                }
                
                // if not opponent, is one of our pieces
                else{
                    return (return_row, return_col)
                }
            }
            return_row += row_direction
            return_col += col_direction
        }
        return (return_row, return_col)
    }
    
}
#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
