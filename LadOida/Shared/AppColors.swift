//
//  AppColors.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 15.06.24.
//

import UIKit
import SwiftUI

public class AppColors {
    enum AppColorTypes {
        case primary
        case divider
        case info
    }

    static func color(_ color: AppColorTypes) -> Color {
        AppColors.internalColor(color).color()
    }

    static func color(_ color: AppColorTypes) -> UIColor {
        AppColors.internalColor(color)
    }

    private static func internalColor(_ color: AppColorTypes) -> UIColor {
        switch color {
        case .primary:
            #colorLiteral(red: 0.2462522984, green: 0.6474125981, blue: 0.2099429369, alpha: 1)
        case .divider:
            #colorLiteral(red: 0.8965865374, green: 0.8965864778, blue: 0.8965865374, alpha: 1)
        case .info:
            #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}
