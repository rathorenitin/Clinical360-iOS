//
//  PatientListScene.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 2026-06-22.
//

import SwiftUI

struct PatientListScene {
    static func makeView(dependencies: AppDependencies) -> some View {
        let repository = PatientListRepository(apiClient: dependencies.apiClient)
        let viewModel = PatientListViewModel(repository: repository)
        return PatientListView(viewModel: viewModel, dependencies: dependencies)
    }
}
