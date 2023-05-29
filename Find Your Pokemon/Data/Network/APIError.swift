//
//  ApiError.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import Foundation


enum APIError: Error, CustomStringConvertible{
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    // For user feedback
    var localizedDescription: String {
        switch self{
        case .badURL:
            return "BadURL"
        case .parsing:
            return "Parsing failed"
        case .unknown:
            return "Unknown error"
        case .badResponse(_):
            return "Failed to connect to server"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
        
    }
    
    //For debugging purpose
    var description: String {
        switch self{
        case .unknown:
            return "unkown error"
        case .badURL: return "invalid url"
        case .url (let error): return error?.localizedDescription ?? "url session error"
        case .parsing(let error): return "parsing error. \(error?.localizedDescription ?? "")"
        case .badResponse(let statusCode): return "bad response with status code: \(statusCode)"
        }
    }
}
