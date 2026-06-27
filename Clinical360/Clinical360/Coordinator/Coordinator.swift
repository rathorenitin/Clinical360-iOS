//
//  Coordinator.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 27/06/26.
//

import Foundation
import SwiftUI
import Combine

enum AppRoute: Hashable {
    case patientDetail(patient: PatientRecord)
    case patientReports(patient: PatientRecord)
}

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    private let dependencies: AppDependencies

    init(dependencies: AppDependencies = AppDependencies()) {
        self.dependencies = dependencies
    }

    func makeRootView() -> some View {
        let repository = PatientListRepository(apiClient: dependencies.apiClient)
        let useCase = PatientListUseCase(repository: repository)
        let viewModel = PatientListViewModel(useCase: useCase)

        return PatientListView(viewModel: viewModel,
                               dependencies: dependencies,
                               coordinator: self)
    }

    func makeDestination(for route: AppRoute) -> some View {
        switch route {
        case let .patientDetail(patient):
            return AnyView(PatientDetailScene.makeView(patient: patient,
                                                      dependencies: dependencies,
                                                      coordinator: self))
        case let .patientReports(patient):
            return AnyView(PatientReportsScene.makeView(for: patient,
                                                       dependencies: dependencies,
                                                       coordinator: self))
        }
    }

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
