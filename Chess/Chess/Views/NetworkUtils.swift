//
//  NetworkUtils.swift
//  Chess
//
//  Created by Michael Zheng on 2023-12-21.
//

import Foundation
import SwiftUI

struct NetworkUtils {
    static var HTTP_URL: String = "http://127.0.0.1:5000" // local flask server
    static var debug: Bool = false // for debug messages
    
    // send string representation of board to backend server
    static func postBoard(board: String, difficulty: Int) {
        guard let url = URL(string: HTTP_URL + "/post-board") else {
            if debug {
                print("not valid")
            }
            return
        }
        
        let body: [String: Any] = ["board": board, "difficulty": difficulty]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            if debug {
                print("Error: Cannot create JSON from body")
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if debug {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                if debug {
                    print("Response: \(responseString)")
                }
            }
        }.resume()
    }
    
    // get the board after opponent move from server
    static func getBoard(board: String) async throws -> String {
        guard let url = URL(string: HTTP_URL + "/get-board") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let dataString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return dataString // Return the string directly
    }
}
