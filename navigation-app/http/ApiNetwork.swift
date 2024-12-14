//
//  ApiNetwork.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 13/12/2024.
//

import Foundation

class ApiNetwork {
    struct Place : Codable, Identifiable{
        let id: String;
        let name: String;
        let score: Float
        let description: String
        let mainImage: String
        let images: [String]
        
        let reviews: [Reviews]
    }
    
    struct Reviews : Codable {
        let user: User
        let score: Float
        let message: String
    }
    
    struct User : Codable {
        let email: String
        let name: String
        let lastName: String
    }
    
    func getAllTouristicPlaces() async throws -> [Place] {
        let url = URL(string: "http://localhost:3000/touristic-places")
        
        let (data, response) = try await URLSession.shared.data(from: url!)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiErrors.apiError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Place].self, from: data)
        } catch ApiErrors.dataType {
            print("Error decoding data")
            throw ApiErrors.dataType
        }
        
    }
    
    enum ApiErrors : Error {
        case apiError
        case dataType
    }
    
    
}
