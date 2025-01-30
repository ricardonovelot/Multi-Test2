import SwiftUI

let textDarkest = Color(hue: 0, saturation: 0, brightness: 0.14)

extension Text {
    // H1 - 36pt Light
    func h1() -> some View  {
        self.font(.system(size: 36, weight: .light))
            .lineSpacing(36 * 0.4)
            .foregroundStyle(textDarkest)
    }
    
    // H2 - 32pt Heavy
    func h2() -> some View  {
        self.font(.system(size: 32, weight: .semibold)) // discrepancy with KitchenAid App Library
            .lineSpacing(32 * 0.4)
            .foregroundStyle(textDarkest)
    }
    
    // H3 - 24pt Heavy
    func h3() -> some View  {
        self.font(.system(size: 24, weight: .semibold))
            .lineSpacing(8)
            .foregroundStyle(textDarkest)
    }
    
    // H4 - 24pt Heavy
    func h4() -> some View  {
        self.font(.system(size: 24, weight: .semibold))
            .lineSpacing(-4)
            .foregroundStyle(textDarkest)
    }
    
    // H5 - 20pt Heavy
    func h5() -> some View  {
        self.font(.system(size: 20, weight: .semibold))
            .lineSpacing(8)
            .tracking(-0.5)
            .foregroundStyle(textDarkest)
    }
    
    // Disclaimer - 12pt Medium
    func disclaimer() -> some View  {
        self.font(.system(size: 12, weight: .medium))
            .lineSpacing(8)
            .tracking(2.5)
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
            .foregroundStyle(textDarkest)
    }
    
    // Paragraph Medium Bold - 16pt Bold
    func paragraphMediumBold() -> some View  {
        self.font(.system(size: 16, weight: .bold))
            .lineSpacing(8)
            .foregroundStyle(textDarkest)
    }
    
    // Paragraph Medium - 16pt Medium
    func paragraphMedium() -> some View  {
        self.font(.system(size: 16, weight: .medium))
            .lineSpacing(8)
            .foregroundStyle(textDarkest)
        
    }
    
    // Paragraph Small - 14pt Medium
    func paragraphSmall() -> some View  {
        self.font(.system(size: 14, weight: .medium))
            .lineSpacing(10)
            .foregroundStyle(textDarkest)
    }
    
    // Paragraph Small Oblique - 12pt Medium Oblique
    func paragraphSmallOblique() -> some View  {
        self.font(.system(size: 12, weight: .medium))
            .lineSpacing(12)
            .italic()
            .foregroundStyle(textDarkest)
    }
    
    // Paragraph Small Oblique Underlined - 12pt Medium Oblique
    func paragraphSmallObliqueUnderlined() -> some View {
        self.font(.system(size: 12, weight: .medium))
            .lineSpacing(12)
            .italic()
            .underline()
            .foregroundStyle(textDarkest)
    }
    
    // Paragraph Extra Small - 12pt Medium Oblique
    func paragraphExtraSmall() -> some View  {
        self.font(.system(size: 12, weight: .medium))
            .lineSpacing(12)
            .foregroundStyle(textDarkest)
    }
    // Button Text Style - 12pt Medium
    func buttonText() -> some View {
        self.font(.system(size: 12, weight: .medium))
            .lineSpacing(2)
            .tracking(2)
            .textCase(.uppercase)
    }
}
