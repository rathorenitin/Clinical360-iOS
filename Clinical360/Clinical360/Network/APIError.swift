//
//  APIError.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 14/06/26.
//

import Foundation

enum APIError: Error {
    case noBaseUrl
    case invalidRequest
    case responseDecodingError
    case serverError
}
