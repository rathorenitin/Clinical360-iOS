//
//  PatientDetailRequest.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 18/06/26.
//

struct PatientDetailRequest: ApiRequestProtocol {
    
    let url: String = ApiEndPoint.patientsDetails.absoluteURL ?? ""
    var method: HTTPMethodType = .get
    var parameters: Parameters = [:]
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
}
