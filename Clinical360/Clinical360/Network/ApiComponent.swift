//
//  ApiComponent.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 15/06/26.
//

import Foundation

protocol ApiComponent {
    var baseURL: String? { get }
    var path: String { get }
    var absoluteURL: String? { get }
}
