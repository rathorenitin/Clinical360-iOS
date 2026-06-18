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
}

final class PatientDetailViewModel: ObservableObject, PatientDetailViewModelProtocol {
    private let repository: PatientDetailRepositoryProtocol
    @Published var state: ViewState<PatientDetail> = .loading
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
}
