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
    let repository: PatientListRepositoryProtocol
    
    init(repository: PatientListRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPatients() async {
        do {
            let respone = try await self.repository.getPatients()
            print(respone?.records)
        } catch {
            print(error)
        }
    }
}
