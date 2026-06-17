//
//  PatientListViewModel.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 13/06/26.
//

import Foundation
import Combine

enum ViewState<Result> {
    case loading
    case loaded(Result)
    case empty(String)
    case error(String)
}

protocol PatientListViewModelProtocol {
    func getPatients() async
}

final class PatientListViewModel: ObservableObject, PatientListViewModelProtocol {
    private let repository: PatientListRepositoryProtocol
    @Published var state: ViewState<[PatientRecord]> = .loading

    
    init(repository: PatientListRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPatients() async {
        do {
            let respone = try await self.repository.getPatients()
            state = respone.records.isEmpty ? .empty("No Patients found") : .loaded(respone.records)
            print(respone.records)
        } catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
}
