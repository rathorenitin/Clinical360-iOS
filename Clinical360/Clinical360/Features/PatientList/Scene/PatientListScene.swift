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
        let useCase = PatientListUseCase(repository: repository)
        let viewModel = PatientListViewModel(useCase: useCase)
        return PatientListView(viewModel: viewModel, dependencies: dependencies)
    }
}
