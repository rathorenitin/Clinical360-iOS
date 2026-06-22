//
//  PatientReportsRepository.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import Foundation

protocol PatientReportsRepositoryProtocol {
    func getPatientReports(for patientId: Int) async throws -> [Report]
    func downloadPatientReport(reports:[Report], patientId: Int) async throws -> [URL]
    func isReportSaved(report: Report, patientId: Int) -> Bool
    func localFileURL(for report: Report, patientId: Int) -> URL
}

final class PatientReportsRepository: PatientReportsRepositoryProtocol {
    private let apiClient: ApiClientProtocol
    private let downloadManger: DownloadMangerProtocol

    // MARK: - initialization
    init(apiClient: ApiClientProtocol, downloadManger: DownloadMangerProtocol) {
        self.apiClient = apiClient
        self.downloadManger = downloadManger
    }

    // MARK: - Get PatientReports
    func getPatientReports(for patientId: Int) async throws -> [Report] {
        let patientReportRequest = PatientReportRequest(patientId: patientId)
        let patientReports: [PatientReport]? = try await self.apiClient.executeAsync(request: patientReportRequest)
        guard patientReports != nil && patientReports?.first?.reports.isEmpty == false,
              let reports = patientReports?.first?.reports else {
            return []
        }

        return reports
    }

    // MARK: - Download PatientReport

    func downloadPatientReport(reports:[Report], patientId: Int) async throws -> [URL] {
        var savedURLs: [URL] = []
        for report in reports {
            let destination = downloadManger.localFileURL(rootDirectory: "\(patientId)", path: report.type, fileName: report.reportId)
            if downloadManger.fileExists(rootDirectory: "\(patientId)", path: report.type, fileName: report.reportId) {
                savedURLs.append(destination)
                continue
            }

            let patientUrlRequest = DownloadPatientReportRequest(url: report.url)
            let tempDirectoryPath = try await self.apiClient.fileDownloadAsync(request: patientUrlRequest)

            let url = try downloadManger.saveReport(tempURL: tempDirectoryPath,
                                                    rootDirectory: "\(patientId)",
                                                    path: report.type,
                                                    fileName: report.reportId)
            savedURLs.append(url)
        }

        return savedURLs
    }

    func isReportSaved(report: Report, patientId: Int) -> Bool {
        return downloadManger.fileExists(rootDirectory: "\(patientId)", path: report.type, fileName: report.reportId)
    }

    func localFileURL(for report: Report, patientId: Int) -> URL {
        return downloadManger.localFileURL(rootDirectory: "\(patientId)", path: report.type, fileName: report.reportId)
    }
}
