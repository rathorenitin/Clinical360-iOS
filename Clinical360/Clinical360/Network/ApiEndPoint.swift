//
//  ApiEndPoint.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 15/06/26.
//

import Foundation

/*
 Instead of using below constant variable we should fetch it from config on basis of enviorment
 */
enum AppConstants {
    static let baseURL = "https://api-dev-patient-portal.azurewebsites.net/api/"
}

enum ApiEndPoint {
    case patientsList
    case patientsDetails
}

extension ApiEndPoint: ApiComponent {
    var baseURL: String? {
        AppConstants.baseURL // we can fetch this from dependency
    }
    
    var path: String {
        switch self {
        case .patientsList:
            return "Patients"
        case .patientsDetails:
            return "Patients/PatientDetails"
        }
    }
    
    var absoluteURL: String? {
        guard let urlString = baseURL else {
            return nil
        }
        return urlString.appending(self.path)
    }
    
}
