//
//  RadioButtonView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 15.06.24.
//

import SwiftUI

struct RadioButtonView: View {

    let isSelected: Bool

    var body: some View {
        if isSelected {
            Circle()
                .stroke(.black, lineWidth: 3)
                .fill(AppColors.color(.primary))
                .frame(width: 18, height: 18)
        } else {
            Circle()
                .stroke(.black, lineWidth: 2)
                .fill(.clear)
                .frame(width: 18, height: 18)
        }
    }
}
