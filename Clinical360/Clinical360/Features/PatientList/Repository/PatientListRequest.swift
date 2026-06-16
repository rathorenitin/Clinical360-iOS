//
//  PatientListRequest.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 15/06/26.
//

struct PatientListRequest: ApiRequestProtocol {
    
    let url: String = ApiEndPoint.patientsList.absoluteURL ?? ""
    var method: HTTPMethodType = .get
    var parameters: Parameters = [:]
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
}
