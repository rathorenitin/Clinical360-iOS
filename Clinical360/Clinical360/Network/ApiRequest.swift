//
//  ApiRequest.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 14/06/26.
//

import Foundation

typealias Dictionary = [String: Any]
typealias HTTPHeaders = Dictionary
typealias Parameters = Dictionary

/// HTTPMethod Method Types
enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

/// Api Request Protocol
protocol ApiRequestProtocol {
    var url: String { get }
    var parameters: Parameters { get }
    var method: HTTPMethodType { get }
    var headers: HTTPHeaders? { get }
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

/// Api Request Protocol default implementation
extension ApiRequestProtocol {
    var method: HTTPMethodType {
        .get
    }
    
    var parameters: Parameters {
        [:]
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        JSONDecoder.KeyDecodingStrategy.useDefaultKeys
    }
}


extension ApiRequestProtocol {
    
    func getRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: self.url) else {
            throw APIError.noBaseUrl
        }
        
        urlComponents.queryItems = self.parameters.compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
    
    func getURLRequest() -> Result<URLRequest, APIError> {
        guard var urlComponents = URLComponents(string: self.url) else {
            return .failure(APIError.noBaseUrl)
        }
        
        urlComponents.queryItems = self.parameters.compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents.url else {
            return .failure(APIError.invalidRequest)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        return .success(urlRequest)
    }
}
