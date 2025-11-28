import SwiftUI

protocol ThemeFonts {
    var largeTitle: Font { get }
    var title: Font { get }
    var headline: Font { get }
    var body: Font { get }
    var caption: Font { get }
    var button: Font { get }
}

struct AppThemeFonts: ThemeFonts {
    let largeTitle = Font.system(size: Dimens.FontSize.largeTitle, weight: .bold)
    let title = Font.system(size: Dimens.FontSize.title, weight: .semibold)
    let headline = Font.system(size: Dimens.FontSize.body, weight: .semibold)
    let body = Font.system(size: Dimens.FontSize.body, weight: .regular)
    let caption = Font.system(size: Dimens.FontSize.small, weight: .regular)
    let button = Font.system(size: Dimens.FontSize.medium, weight: .bold)
}

