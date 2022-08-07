//
//  APIEnvironment.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//
import Foundation
enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return "https://\(subdomain()).\(domain())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "typicode.com"
        case .staging:
            return "typicode.com"
        case .production:
            return "typicode.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "jsonplaceholder"
        }
    }
    
//    func route() -> String {
//        return "/api/v1"
//    }
}
