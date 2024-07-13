//
//  AppFonts.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 15.06.24.
//

import SwiftUI
import UIKit

public enum AppFonts {
    public enum AppFont {
        case title
        case title1
        case title2
        case subtitle
        case body
        case body1
        case body2
        case caption
    }

    static func regular(_ font: AppFont) -> Font {
        switch font {
        case .title:
            AppFonts.regular(size: 32)
        case .title1:
            AppFonts.regular(size: 26)
        case .title2:
            AppFonts.regular(size: 22)
        case .subtitle:
            AppFonts.regular(size: 18)
        case .body:
            AppFonts.regular(size: 16)
        case .body1:
            AppFonts.regular(size: 14)
        case .body2:
            AppFonts.regular(size: 12)
        case .caption:
            AppFonts.regular(size: 10)
        }
    }

    static func bold(_ font: AppFont) -> Font {
        switch font {
        case .title:
            AppFonts.bold(size: 32)
        case .title1:
            AppFonts.bold(size: 26)
        case .title2:
            AppFonts.bold(size: 22)
        case .subtitle:
            AppFonts.bold(size: 18)
        case .body:
            AppFonts.bold(size: 16)
        case .body1:
            AppFonts.bold(size: 14)
        case .body2:
            AppFonts.bold(size: 12)
        case .caption:
            AppFonts.bold(size: 10)
        }
    }

    private static func regular(
        size: CGFloat
    ) -> Font {
        Font.custom(
            "Montserrat-Regular",
            size: size
        )
    }

    private static func bold(
        size: CGFloat
    ) -> Font {
        Font.custom(
            "Montserrat-Bold",
            size: size
        )
    }
}
