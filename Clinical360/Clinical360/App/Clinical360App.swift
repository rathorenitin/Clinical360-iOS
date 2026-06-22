//
//  Clinical360App.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 13/06/26.
//

import SwiftUI

@main
struct Clinical360App: App {
    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            PatientListScene.makeView(dependencies: dependencies)
        }
    }
}
