//
//  PatientListView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 13/06/26.
//

import SwiftUI

struct PatientListView: View {
    
    @StateObject var viewModel: PatientListViewModel
    
    
    var body: some View {
        VStack {
            Text("Patient List")
        }
        .task {
            await viewModel.getPatients()
        }
    }
}
