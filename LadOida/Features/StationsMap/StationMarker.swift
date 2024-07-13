//
//  StationMarker.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 13.07.24.
//

import SwiftUI

struct StationMarker: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(AppColors.color(.primary))

            Image(systemName: "ev.charger.fill")
                .renderingMode(.template)
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundStyle(.white)
                .shadow(radius: 15)
        }
        .frame(width: 30, height: 30)
    }
}
