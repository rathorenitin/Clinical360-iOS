//
//  Clinical360App.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 13/06/26.
//

import SwiftUI

@main
struct Clinical360App: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = ApiClient()
            let PatientListRepository = PatientListRepository(apiClient: apiClient)
            PatientListView(viewModel: PatientListViewModel(repository: PatientListRepository))
        }
    }
}
