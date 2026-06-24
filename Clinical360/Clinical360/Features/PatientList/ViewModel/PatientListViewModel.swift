//
//  PatientListViewModel.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 13/06/26.
//

import Foundation
import Combine

protocol PatientListViewModelProtocol {
    func getPatients() async
}

final class PatientListViewModel: ObservableObject, PatientListViewModelProtocol {
    private let useCase: PatientListUseCaseProtocol
    @Published var state: ViewState<[PatientRecord]> = .loading

    init(useCase: PatientListUseCaseProtocol) {
        self.useCase = useCase
    }

    func getPatients() async {
        do {
            let respone = try await self.useCase.getPatients()
            state = respone.records.isEmpty ? .empty("No Patients found") : .loaded(respone.records)
            print(respone.records)
        } catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
}
