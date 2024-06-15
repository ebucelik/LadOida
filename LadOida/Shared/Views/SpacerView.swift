//
//  SpacerView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 15.06.24.
//

import SwiftUI

struct SpacerView: View {

    let height: CGFloat

    init(height: CGFloat = 4) {
        self.height = height
    }

    var body: some View {
        AppColors.color(.divider)
            .frame(height: height)
            .frame(maxWidth: .infinity)
    }
}
