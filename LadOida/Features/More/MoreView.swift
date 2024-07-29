//
//  MoreView.swift
//  LadOida
//
//  Created by Ing. Ebu Bekir Celik, BSc, MSc on 26.07.24.
//

import SwiftUI
import StoreKit

struct MoreView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                Spacer()

                Text("Sind Sie zufrieden mit der App?\nDann bewerten Sie uns im App Store.")
                    .multilineTextAlignment(.center)
                    .font(AppFonts.regular(.subtitle))
                    .padding(.bottom, 20)

                if let windowScene = UIApplication.shared.connectedScenes.first(
                    where: { $0.activationState == .foregroundActive }
                ) as? UIWindowScene {
                    Button {
                        SKStoreReviewController.requestReview(in: windowScene)
                    } label: {
                        HStack {
                            Text("Jetzt bewerten ⭐️")
                                .font(AppFonts.regular(.subtitle))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .background(AppColors.color(.primary))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

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
