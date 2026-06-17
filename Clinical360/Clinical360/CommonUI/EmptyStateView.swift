//
//  EmptyStateView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 17/06/26.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    var body: some View {
        VStack {
            Text(message)
                .foregroundStyle(.secondary)
        }
    }
}
