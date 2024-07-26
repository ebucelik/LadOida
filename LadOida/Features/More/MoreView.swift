//
//  MoreView.swift
//  LadOida
//
//  Created by Ing. Ebu Bekir Celik, BSc, MSc on 26.07.24.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                Spacer()

                Text("Sind Sie zufrieden mit der App?\nDann bewerten Sie uns im App Store 🫶🏼")
                    .multilineTextAlignment(.center)
                    .font(AppFonts.regular(.subtitle))

                Spacer()

                if let releaseVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                   let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                    Text("Version: \(releaseVersion) (\(buildVersion))")
                        .font(AppFonts.regular(.body))
                        .foregroundStyle(AppColors.color(.info))
                        .textSelection(.enabled)
                }

                Text("© 2024 Ing. Ebu Bekir Celik, BSc, MSc")
                    .font(AppFonts.regular(.body))
                    .foregroundStyle(AppColors.color(.info))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .navigationTitle("Lad Oida")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
