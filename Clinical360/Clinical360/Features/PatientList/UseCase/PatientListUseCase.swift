//
//  PatientListUseCase.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 24/06/26.
//

import Foundation

protocol PatientListUseCaseProtocol {
    func getPatients() async throws -> PagedPatientsResponse
}

final class PatientListUseCase: PatientListUseCaseProtocol {
    private let repository: PatientListRepositoryProtocol

    init(repository: PatientListRepositoryProtocol) {
        self.repository = repository
    }

    func getPatients() async throws -> PagedPatientsResponse {
        return try await repository.getPatients()
    }
}
