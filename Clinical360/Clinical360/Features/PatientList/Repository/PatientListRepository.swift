//
//  PatientListRepository.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 15/06/26.
//

import Foundation

protocol PatientListRepositoryProtocol {
    
    func getPatients() async throws -> PagedPatientsResponse?
    
}

enum PatientRepositoryError : Error {
    case defaultError
}

// MARK: - PatientRepository

final class PatientListRepository: PatientListRepositoryProtocol {
    
    private let apiClient: ApiClientProtocol

    // MARK: - initialization
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    
    // MARK: - Get Patients
    func getPatients() async throws -> PagedPatientsResponse? {
        let patientUrlRequest = PatientListRequest(parameters: ["Take": "10",
                                                      "Skip": "0"])
        return try await self.apiClient.executeAsync(request: patientUrlRequest)
    }
    
}
