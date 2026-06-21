//
//  PatientDetailRepository.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 18/06/26.
//

import Foundation

protocol PatientDetailRepositoryProtocol {
    
    func getPatientDetail(patientId: String) async throws -> PatientDetail
}

// MARK: - PatientRepository

final class PatientDetailRepository: PatientDetailRepositoryProtocol {
    
    private let apiClient: ApiClientProtocol

    // MARK: - initialization
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    // MARK: - Get PatientDetail
    func getPatientDetail(patientId: String) async throws -> PatientDetail {
        let patientUrlRequest = PatientDetailRequest(parameters: ["id": patientId])
        return try await self.apiClient.executeAsync(request: patientUrlRequest)
    }
}
