//
//  PatientReportRequest.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import Foundation

struct PatientReportRequest: ApiRequestProtocol {
    
    let url: String = ApiEndPoint.downloadReport.absoluteURL ?? ""
    var method: HTTPMethodType = .post
    var httpBody: Data?
    var headers: HTTPHeaders?
    
    init(patientId: Int) {
        let payload: [Int] = [patientId]
        httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
        headers = ["Content-Type" : "application/json"]
    }
}
