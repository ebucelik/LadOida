//
//  SearchItemView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 15.06.24.
//

import SwiftUI
import MapKit

struct SearchItemView: View {
    let localSearchCompletion: MKLocalSearchCompletion
    let isSelected: Bool

    init(
        localSearchCompletion: MKLocalSearchCompletion,
        isSelected: Bool = false
    ) {
        self.localSearchCompletion = localSearchCompletion
        self.isSelected = isSelected
    }

    var body: some View {
        HStack(spacing: 16) {
            RadioButtonView(isSelected: isSelected)

            VStack(alignment: .leading, spacing: 8) {
                Text(localSearchCompletion.title)
                    .font(AppFonts.regular(.subtitle))

                Text(localSearchCompletion.subtitle)
                    .font(AppFonts.regular(.body1))
            }
        }
        .padding()
    }
}
