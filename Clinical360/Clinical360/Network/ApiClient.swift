//
//  ApiClient.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 14/06/26.
//

import Foundation

protocol ApiClientProtocol {
    func execute<T: Decodable>(
        request: ApiRequestProtocol,
        completion: @escaping (Result<T?, APIError>?) -> Void
    )
    func executeAsync<T: Decodable>(request: ApiRequestProtocol) async throws -> T
    func fileDownloadAsync(request: ApiRequestProtocol) async throws -> URL
}

final class ApiClient : ApiClientProtocol {
    
    func fileDownloadAsync(request: ApiRequestProtocol) async throws -> URL {
        
        do {
            let (fileUrl, response) = try await URLSession.shared.download(for: request.getRequest())
            
            guard let http = response as? HTTPURLResponse else {
                throw APIError.serverError
            }
            
            guard (200...299).contains(http.statusCode) else {
                throw APIError.serverError
            }
            
            print("tmp directory path => \(fileUrl)")
            
            return fileUrl
        }
        catch let error {
            print("HttpUtility.fileDownloadAsync => \(error)")
            throw APIError.serverError
        }
    }
    
    func executeAsync<T>(request: ApiRequestProtocol) async throws -> T where T : Decodable {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request.getRequest())
            
            guard let http = response as? HTTPURLResponse else {
                throw APIError.serverError
            }
            
            guard (200...299).contains(http.statusCode) else {
                throw APIError.serverError
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = request.dateDecodingStrategy
                
                return try decoder.decode(T.self, from: data)
                
            } catch let decodingError {
                print("HttpUtility decodingError => \(decodingError)")
                throw APIError.serverError
            }
        }
        catch let error {
            print("HttpUtility => \(error)")
            throw APIError.serverError
        }
    }
    
    
    func execute<T:Decodable>(request: ApiRequestProtocol,
                              completion: @escaping (Result<T?, APIError>?) -> Void) {
        switch request.getURLRequest() {
        case .success(let urlRequest):
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                guard error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                guard let http = response as? HTTPURLResponse else {
                    completion(.failure(.serverError))
                    return
                }
                
                guard (200...299).contains(http.statusCode) else {
                    completion(.failure(.serverError))
                    return
                }
                
                
                guard let data else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = request.dateDecodingStrategy
                    
                    let decoded = try decoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.responseDecodingError))
                }
                
            }.resume()
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
