//
//  DownloadPatientReportRequest.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import Foundation

struct DownloadPatientReportRequest: ApiRequestProtocol {
    
    let url: String
    var method: HTTPMethodType = .get
    var httpBody: Data?
    var headers: HTTPHeaders?
    
    init(url: String) {
        self.url = url
        headers = ["Content-Type" : "application/json"]
    }
}
