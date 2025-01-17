//
//  ProSwiftUIView.swift
//  myclock
//
//  Created by  玉城 on 2024/4/26.
//

import SwiftUI
import StoreKit

struct ProSwiftUIView: View {
    @StateObject var storeKit = StoreKitManager()
    @State var isPurchased: Bool = false
    
    func hexToColor(hex: String, alpha: Double = 1.0) -> Color {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        let scanner = Scanner(string: formattedHex)
        var color: UInt64 = 0
        
        if scanner.scanHexInt64(&color) {
            let red = Double((color & 0xFF0000) >> 16) / 255.0
            let green = Double((color & 0x00FF00) >> 8) / 255.0
            let blue = Double(color & 0x0000FF) / 255.0
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        } else {
            // 返回默认颜色，当转换失败时
            return Color.black
        }
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        VStack{
            HStack(alignment: .center,spacing:20){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward").font(.system(size: 24))
                }.padding()
                Spacer()
                Text("Tip").font(.system(size: 18)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
             
                Spacer()
                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
                }) {
//                    Text("恢复购买")
                    Image(systemName: "chevron.backward.2").font(.system(size: 24))
                }.padding().opacity(0)
            }
           
            Spacer().frame(height: 60)
            
            HStack{
                Spacer().frame(width: 50)
                
                VStack (alignment: .leading,spacing: 28){
                    Group {
                        HStack{
                            
//                            Image(systemName: "goforward.5").font(.system(size: 20))
                            Text("This is a free app, thank you for your support.")
                        }
                       
                       
//                        HStack{
//                            Image(systemName: "lock.open").font(.system(size: 20))
//                            Text("Unlimited Daily Access")
//                        }
//                       
//                        HStack{
//                            Image(systemName: "lightbulb.2").font(.system(size: 20))
//                            Text("All Future Features")
//                        }
                      
                    }.font(.system(size: 18)).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
//                    Text("未来所有的新功能")
                  
                    
                    
                }
                
                Spacer()
            }.padding(.bottom,50)
            
            
           
            ForEach(storeKit.storeProducts) {
                                    product in HStack{
            VStack{
                HStack(alignment: .lastTextBaseline){
                    Spacer().frame(width: 30)
//                    Text("¥").font(.system(size: 24)).foregroundColor(Color.white)
                    Text(product.displayPrice).font(.system(size: 40)).foregroundColor(Color.white)
//                    Text("  LifeTime").font(.system(size: 16))
                    Spacer()
                }
                .padding(.vertical,0)
            
            
                Button(action: {
//                        print(storeKit.storeProducts)
                  
                        if isPurchased {
                            return
                        }
                        Task{
                            try await storeKit.purchase(product)
                       }
                    
                       }) {
//                           CourseItem(storeKit: storeKit, product: product)
                           
                           if isPurchased {
                               Text("Unlocked").font(.system(size: 20))
                               Text(Image(systemName: "checkmark"))
                                   .bold()
                                   .padding(10).foregroundColor(hexToColor(hex:"192d32"))
                               
                           } else {
                               Text("Tip").font(.system(size: 18))
                           }
                           
                       }
                       .frame(maxWidth: .infinity, minHeight: 50)
                      
                       .foregroundColor(hexToColor(hex:"192d32"))
                       .background(hexToColor(hex:"d4be87"))
                       .cornerRadius(5)
                       .padding(.horizontal,20)
                       .padding(.top,-10)
                       .onChange(of: storeKit.purchasedCourses) { _ in
                           Task {
                               isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                               UserDefaults.standard.set(isPurchased, forKey: "isPurchased")
                           }
                       }
            }
                                    }
            }
                  
            
            
            
            
            HStack{
//                Text("使用条款").font(.system(size: 14)).opacity(0.6)
//                Spacer()
//                Text("隐私协议").font(.system(size: 14)).opacity(0.6)
//                Spacer()
                
                Button(action: {
                    Task {
                        //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                        //Call this function only in response to an explicit user action, such as tapping a button.
                        try? await AppStore.sync()
                    }
//                    self.presentationMode.wrappedValue.dismiss()
                }) {
//                    Text("恢复购买").font(.system(size: 14)).opacity(0.6)
                }.padding()
             
//                Button("Restore Purchases", action: {
//
//                })
               
            }
            
            .padding(.horizontal,40)
            .padding(.top,0)
            
            
            
            
            
            
            
            Spacer()
            
          
            
            
         
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .foregroundColor(hexToColor(hex:"d4be87"))
        .background(hexToColor(hex:"192d32"))
        .navigationBarHidden(true)
        .onAppear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//            UINavigationController.attemptRotationToDeviceOrientation()
            
            
            if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
                    // iOS版本大于等于16.0，使用新的方法
                UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
            } else {
                // iOS版本小于16.0，使用旧的方法
//                    UINavigationController.attemptRotationToDeviceOrientation()
            }
            
        }
        .onDisappear {
//            DispatchQueue.main.async {
//                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                // UINavigationController.attemptRotationToDeviceOrientation()
////                UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
//                if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
//                        // iOS版本大于等于16.0，使用新的方法
//                        UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
//                    } else {
//                        // iOS版本小于16.0，使用旧的方法
////                            UINavigationController.attemptRotationToDeviceOrientation()
//                    }
//                
//            }
        }
    

        
        
        
        
    }
    
    
}

struct CourseItem: View {
    @ObservedObject var storeKit : StoreKitManager
    @State var isPurchased: Bool = false
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
            } else {
//                Text(product.displayPrice)
//                    .padding(10)
            }
        }
        .onChange(of: storeKit.purchasedCourses) { _ in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
    }
}



#Preview {
    ProSwiftUIView()
}

