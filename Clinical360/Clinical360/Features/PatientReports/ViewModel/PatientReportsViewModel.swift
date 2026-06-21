//
//  PatientReportsViewModel.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import Foundation
import Combine

protocol PatientReportsViewModelProtocol: ObservableObject {
    func getPatientReports() async
    func downloadReport(_ report: Report) async
    func isReportSaved(_ report: Report) -> Bool
    func localFileURL(for report: Report) -> URL
}

final class PatientReportsViewModel: ObservableObject, PatientReportsViewModelProtocol {
    private let repository: PatientReportsRepositoryProtocol
    @Published var state: ViewState<[Report]> = .loading
    @Published var reports: [Report] = []
    @Published var currentReportURL: URL?
    @Published var downloadingReportId: String?
    let patient: PatientRecord
    
    init(patient: PatientRecord, repository: PatientReportsRepositoryProtocol) {
        self.patient = patient
        self.repository = repository
    }
    
    func getPatientReports() async {
        self.state = .loading
        
        do {
            let respone = try await self.repository.getPatientReports(for: patient.id)
            self.reports = respone
            self.state = respone.isEmpty ? .empty("No reports found") : .loaded(respone)
        } catch {
            print(error)
            self.state = .error(error.localizedDescription)
        }
    }
    
    func downloadReport(_ report: Report) async {
        self.downloadingReportId = report.reportId
        
        defer {
            self.downloadingReportId = nil
        }
        
        do {
            let saved = try await self.repository.downloadPatientReport(reports: [report], patientId: patient.id)
            if let first = saved.first {
                self.currentReportURL = first
            }
        } catch {
            print(error)
        }
    }
    
    func isReportSaved(_ report: Report) -> Bool {
        return self.repository.isReportSaved(report: report, patientId: patient.id)
    }
    
    func isDownloading(_ report: Report) -> Bool {
        return self.downloadingReportId == report.reportId
    }
    
    func localFileURL(for report: Report) -> URL {
        return self.repository.localFileURL(for: report, patientId: patient.id)
    }
}
