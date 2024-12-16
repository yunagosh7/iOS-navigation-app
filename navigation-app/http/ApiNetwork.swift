//
//  ApiNetwork.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 13/12/2024.
//

import Foundation

class ApiNetwork {
    
    struct PreviewPlace : Codable, Identifiable {
        let id: String
        let name: String
        let score: Float
        let mainImage: String
        let description: String
    }
    
    struct Place : Codable, Identifiable {
        let id: String
        let name: String
        let score: Float
        let mainImage: String
        let description: String
        let images: [String]
        let reviews: [Reviews]
    }
    
    struct Reviews : Codable, Identifiable {
        
        var id: String { user.email }
        
        let user: User
        let score: Float
        let message: String
    }
    
    struct User : Codable {
        let email: String
        let name: String
        let lastName: String
    }
    
    func getAllTouristicPlaces() async throws -> [PreviewPlace] {
        let url = URL(string: "http://localhost:3000/api")
        
        let (data, response) = try await URLSession.shared.data(from: url!)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiErrors.apiError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([PreviewPlace].self, from: data)
        } catch ApiErrors.dataType {
            print("Error decoding data")
            throw ApiErrors.dataType
        }
        
    }
    
    func getPlaceById(id: String) async throws -> Place {
        let url =  URL(string: "http://localhost:3000/api/\(id)")
        
        let (data, response) = try await URLSession.shared.data(from: url!)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiErrors.apiError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Place.self, from: data)
        } catch ApiErrors.dataType {
            throw ApiErrors.dataType
        }
    }
    
    enum ApiErrors : Error {
        case apiError
        case dataType
    }
    
    
}
