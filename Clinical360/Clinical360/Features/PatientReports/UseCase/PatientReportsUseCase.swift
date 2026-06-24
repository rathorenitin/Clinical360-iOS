//
//  PatientReportsUseCase.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 24/06/26.
//

import Foundation

protocol PatientReportsUseCaseProtocol {
    func getPatientReports(for patientId: Int) async throws -> [Report]
    func downloadPatientReport(reports:[Report], patientId: Int) async throws -> [URL]
    func isReportSaved(report: Report, patientId: Int) -> Bool
    func localFileURL(for report: Report, patientId: Int) -> URL
}

final class PatientReportsUseCase: PatientReportsUseCaseProtocol {
    private let repository: PatientReportsRepositoryProtocol

    init(repository: PatientReportsRepositoryProtocol) {
        self.repository = repository
    }

    func getPatientReports(for patientId: Int) async throws -> [Report] {
        return try await repository.getPatientReports(for: patientId)
    }

    func downloadPatientReport(reports:[Report], patientId: Int) async throws -> [URL] {
        return try await repository.downloadPatientReport(reports: reports, patientId: patientId)
    }

    func isReportSaved(report: Report, patientId: Int) -> Bool {
        return repository.isReportSaved(report: report, patientId: patientId)
    }

    func localFileURL(for report: Report, patientId: Int) -> URL {
        return repository.localFileURL(for: report, patientId: patientId)
    }
}
