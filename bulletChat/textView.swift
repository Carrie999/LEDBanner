
import SwiftUI
import Marquee

struct Content1View: View {
    @State var duration: Double = 4.0
    @State var autoreverses: Bool = false
    @State var direction: MarqueeDirection = .right2left
    @State var whenNotFit: Bool = false
    var body: some View {
       
        Marquee {
            Text("Bold233232233232323232323232")
                .fontWeight(.bold)
                .font(.custom("SFUIDisplay-Light", size: 40))
                +
                Text(" Underlined")
                .font(.system(size: 30))
                .underline()
                .foregroundColor(.red)
                + Text(" Color")
                .foregroundColor(.blue)
               
        }
        .marqueeDuration(duration)
        .marqueeAutoreverses(autoreverses)
        .marqueeDirection(direction)
         .marqueeWhenNotFit(whenNotFit)
        .marqueeIdleAlignment(.leading)
    }
}
#Preview {
    Content1View()
}



