//
//  LedView.swift
//  bulletChat
//
//  Created by  玉城 on 2024/5/7.
//

import SwiftUI
import Marquee


struct LedView: View {
    @Binding var content: String
    @Binding var textColor: Color
    @Binding var bgColor: Color
    @Binding var overlayColor1: Color
    @Binding var overlayColor2: Color
    @Binding var showOverlayColor: Bool
    @Binding var showStrokeColor: Bool
    @Binding var strokeColor: Color
    @Binding var sliderValue: Double
    @Binding var duration: Double
    
    @State var autoreverses: Bool = false
    @State var direction: MarqueeDirection = .right2left
    @State var whenNotFit: Bool = true
    
//    @State private var content: String = "你好世界"
//    @State private var sliderValue = 0.5
    @State private var isToggleOn = false
//    @State private var textColor: Color  = .white
//    @State private var bgColor: Color  = .black
//    @State private var overlayColor1: Color  = DataColor.hexToColor(hex: "59ced0")
//    @State private var overlayColor2: Color  = DataColor.hexToColor(hex: "e44d71")
//    @State private var showOverlayColor: Bool = false
//    @State private var showStrokeColor: Bool = true
//    @State private var strokeColor: Color = .red
    @State private var isLandscape = true
    @State private var isShowBackButton = true
    @State private var currentDate: Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func customTextView(content: String, textColor: Color, sliderValue: Double, overlayColor1: Color, overlayColor2: Color) -> some View {
        Text(content.isEmpty ? "Hello World" : content)
            .foregroundColor(textColor)
            .font(.system(size: CGFloat(Int(sliderValue / 9 * 19 * 100))))
            .frame(maxWidth: .infinity)
            .padding(.all, 0)
            .shadow(color: overlayColor1.opacity(1), radius: 1, x: 1, y: 1)
            .shadow(color: overlayColor1.opacity(1), radius: 1, x: 1, y: 1)
            .shadow(color: overlayColor1.opacity(1), radius: 1, x: 1, y: 1)
            .shadow(color: overlayColor2.opacity(1), radius: 1, x: -1, y: -1)
            .shadow(color: overlayColor2.opacity(1), radius: 1, x: -1, y: -1)
            .shadow(color: overlayColor2.opacity(1), radius: 1, x: -1, y: -1)
//            .offset(y:-30)
    }
    
    func customTextView2(content: String, textColor: Color, sliderValue: Double, strokeColor: Color) -> some View {
        Text(content.isEmpty ? "Hello World" : content)
            .foregroundColor(textColor)
            .font(.system(size: CGFloat(Int(sliderValue / 9 * 19 * 100))))
            .frame(maxWidth: .infinity)
            .padding(.all, 0)
            .shadow(color: strokeColor, radius: 1)
            .shadow(color: strokeColor, radius: 1)
            .shadow(color: strokeColor, radius: 1)
            .shadow(color: strokeColor, radius: 1)
//            .offset(y:-30)
    }
    
    func customTextView3(content: String, textColor: Color, sliderValue: Double) -> some View {
        Text(content.isEmpty ? "Hello World" : content)
            .foregroundColor(textColor)
            .font(.system(size: CGFloat(Int(sliderValue / 9 * 19 * 100))))
            .frame(maxWidth: .infinity)
    }
    
    var body: some View {

        
      
        ZStack{
            bgColor
            VStack{
                Marquee {
                if showOverlayColor {
                    customTextView(
                       content: content,
                       textColor: textColor,
                       sliderValue: sliderValue,
                       overlayColor1: overlayColor1,
                       overlayColor2: overlayColor2
                   )
                   
                } else {
                    
                    if showStrokeColor {
                        customTextView2(
                                       content: content,
                                       textColor: textColor,
                                       sliderValue: sliderValue,
                                       strokeColor: strokeColor
                                   )
                    } else {
                        customTextView3(
                            content: content,
                                        textColor: textColor,
                                        sliderValue: sliderValue
                                    )
                        
                    }
                    
                }
                }
                .marqueeDuration(duration)
                .marqueeAutoreverses(autoreverses)
                .marqueeDirection(direction)
                 .marqueeWhenNotFit(whenNotFit)
                .marqueeIdleAlignment(.leading)
                
                
               
            }
            
            VStack{
                Spacer().frame(height: 40)
                HStack(alignment: .center,spacing:20){
                    
                    if isShowBackButton {
                        Image(systemName:"chevron.backward")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .opacity(0.6)
//                            .padding(.leading,20)
//                            .padding(.top,20)
                            .frame(width: 60, height:60)
                            .background(DataColor.hexToColor(hex:"6931c5"))
                            .cornerRadius(12)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }.shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                           
                    }
                    Spacer()
                    
                }
                Spacer()
                
            }

            
        }.onTapGesture{
            isShowBackButton.toggle()
        }
      
//        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//            isLandscape = UIDevice.current.orientation.isLandscape
//            
//        }
        .onAppear(){
//            textColor = DataColor.hexToColor(hex: UserDefaults.standard.string(forKey: "textColor") ?? "#ffffff")
//            bgColor = DataColor.hexToColor(hex: UserDefaults.standard.string(forKey: "bgColor") ?? "#ffffff")
//            overlayColor1 = DataColor.hexToColor(hex: UserDefaults.standard.string(forKey: "overlayColor1") ?? "#ffffff")
//            overlayColor2 = DataColor.hexToColor(hex: UserDefaults.standard.string(forKey: "overlayColor2")  ?? "#ffffff")
//
//            strokeColor = DataColor.hexToColor(hex: UserDefaults.standard.string(forKey: "strokeColor")  ?? "#ffffff")
//            if UserDefaults.standard.string(forKey: "content") == "" {
//                content = "hello world"
//            } else {
//                content = UserDefaults.standard.string(forKey: "content") ?? "hello world"
//            }
      
            
//            sliderValue = Double(UserDefaults.standard.string(forKey: "sliderValue") ?? "0.5") ?? 0.5
            
//            UserDefaults.standard.set(String(sliderValue), forKey: ")
            
//            showOverlayColor = UserDefaults.standard.bool(forKey: "showOverlayColor")
            
//            showStrokeColor = UserDefaults.standard.bool(forKey: "showStrokeColor")   
        
            
            
            
            if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                   windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
                
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    //            UINavigationController.attemptRotationToDeviceOrientation()
                
                    // iOS版本大于等于16.0，使用新的方法
                UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
            } else {
                // iOS版本小于16.0，使用旧的方法
//                UINavigationController.attemptRotationToDeviceOrientation()
            }
        }
      
        .onDisappear {
            DispatchQueue.main.async {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                // UINavigationController.attemptRotationToDeviceOrientation()
//                UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
                if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
                        // iOS版本大于等于16.0，使用新的方法
                        UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
                    } else {
                        // iOS版本小于16.0，使用旧的方法
//                        UINavigationController.attemptRotationToDeviceOrientation()
                    }
                
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    LedView()
//}
//
//
