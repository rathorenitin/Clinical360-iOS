//
//  ErrorView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 17/06/26.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retry: (() -> Void)?
    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .foregroundStyle(.red)
            if let retry {
                Button(action: retry) {
                    Text("Retry")
                }
            }
        }
    }
}
