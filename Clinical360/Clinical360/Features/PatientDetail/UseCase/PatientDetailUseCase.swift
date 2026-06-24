//
//  PatientDetailUseCase.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 24/06/26.
//

import Foundation

protocol PatientDetailUseCaseProtocol {
    func getPatientDetail(patientId: String) async throws -> PatientDetail
}

final class PatientDetailUseCase: PatientDetailUseCaseProtocol {
    private let repository: PatientDetailRepositoryProtocol

    init(repository: PatientDetailRepositoryProtocol) {
        self.repository = repository
    }

    func getPatientDetail(patientId: String) async throws -> PatientDetail {
        return try await repository.getPatientDetail(patientId: patientId)
    }
}
