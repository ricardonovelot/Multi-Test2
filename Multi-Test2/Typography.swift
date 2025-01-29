import SwiftUI

extension Text {
    // H1 - 36pt Light
    func h1Style() -> Text {
        self.font(.custom("Avenir-Light", size: 36))
            .lineSpacing(36 * 0.4) // 100% line height
    }
    
    // H2 - 32pt Heavy
    func h2Style() -> Text {
        self.font(.custom("Avenir-Heavy", size: 32))
            .lineSpacing(32 * 0.4) // 100% line height
    }
    
    // H3 - 24pt Heavy
    func h3Style() -> Text {
        self.font(.custom("Avenir-Heavy", size: 24))
            .lineSpacing(8) // 32pt line height
    }
    
    // H4 - 24pt Heavy
    func h4Style() -> Text {
        self.font(.custom("Avenir-Heavy", size: 24))
            .lineSpacing(-4) // 20pt line height
    }
    
    // H5 - 20pt Heavy
    func h5Style() -> Text {
        self.font(.custom("Avenir-Heavy", size: 20))
            .lineSpacing(8) // 28pt line height
            .tracking(-0.5) // -0.5pt letter spacing
    }
    
    // Disclaimer - 12pt Medium
    func disclaimerStyle() -> Text {
        self.font(.custom("Avenir-Medium", size: 12))
            .lineSpacing(8) // 20pt line height
            .tracking(2.5) // 2.5pt letter spacing
    }
    
    // Paragraph Medium Bold - 16pt Bold
    func paragraphMediumBoldStyle() -> Text {
        self.font(.custom("Avenir-Bold", size: 16))
            .lineSpacing(8) // 24pt line height
    }
    
    // Paragraph Medium - 16pt Medium
    func paragraphMediumStyle() -> Text {
        self.font(.custom("Avenir-Medium", size: 16))
            .lineSpacing(8) // 24pt line height
    }
    
    // Paragraph Small - 14pt Medium
    func paragraphSmallStyle() -> Text {
        self.font(.custom("Avenir-Medium", size: 14))
            .lineSpacing(10) // 24pt line height
    }
    
    // Paragraph Small Oblique - 12pt Medium Oblique
    func paragraphSmallObliqueStyle() -> Text {
        self.font(.custom("Avenir-MediumOblique", size: 12))
            .lineSpacing(12) // 24pt line height
    }
    
    // Paragraph Small Oblique Underlined - 12pt Medium Oblique
    func paragraphSmallObliqueUnderlinedStyle() -> Text {
        self.font(.custom("Avenir-MediumOblique", size: 12))
            .lineSpacing(12) // 24pt line height
            .underline()
    }
    
    // Button Text Style - 12pt Medium
    func buttonTextStyle() -> Text {
        self.font(.custom("Avenir-Medium", size: 12))
            .lineSpacing(8) // 20pt line height
            .tracking(2) // 2pt letter spacing
    }
}

// Example usage extension for View to make it easier to apply styles
extension View {
    func typographyStyle<T>(_ style: (Text) -> T) -> some View where T: View {
        if let text = self as? Text {
            return AnyView(style(text))
        }
        return AnyView(self)
    }
}
