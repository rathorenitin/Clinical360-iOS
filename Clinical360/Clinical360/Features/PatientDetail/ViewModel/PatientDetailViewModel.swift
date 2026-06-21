//
//  PatientDetailViewModel.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 18/06/26.
//

import Foundation
import Combine


protocol PatientDetailViewModelProtocol {
    func getPatientDetail() async
    func getPatientReports() async
}

final class PatientDetailViewModel: ObservableObject, PatientDetailViewModelProtocol {
    private let repository: PatientDetailRepositoryProtocol
    @Published var state: ViewState<PatientDetail> = .loading
    @Published var isPatientReportExist: Bool = false
    @Published var reports: [Report] = []
    let patient: PatientRecord
    
    init(patient: PatientRecord, repository: PatientDetailRepositoryProtocol) {
        self.patient = patient
        self.repository = repository
    }
    
    func getPatientDetail() async {
        do {
            let respone = try await self.repository.getPatientDetail(patientId: "\(patient.id)")
            self.state = .loaded(respone)
            print(respone)
        } catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
    
    func getPatientReports() async {
        do {
            let respone = try await self.repository.getPatientReports(for: patient.id)
            self.reports = respone
            self.isPatientReportExist = respone.isEmpty == false
            print("downloadReports -> fetched \(respone.count) reports")
        } catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
}
