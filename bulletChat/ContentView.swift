//
//  ContentView.swift
//  bulletChat
//
//  Created by  玉城 on 2024/5/7.
//
import SwiftUI
import SwiftData
import UIKit
import StoreKit

struct Toast: View {
    let message: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            
        }
        .transition(.move(edge: .bottom))
    }
}

func isIOSVersionGreaterThanOrEqualTo(version: String) -> Bool {
    if #available(iOS 16.0, *) {
        return true
    } else {
        return false
    }
}
func isIOSVersionGreaterThan(version: String) -> Bool {
    if #available(iOS 17.0, *) {
        return true
    } else {
        return false
    }
}

// DataColor.hexToColor(hex: "6931c5"))
//"6931c5" 主色
struct ContentView: View {
    // 定义一个状态变量，用于跟踪TextField的输入
    //    @State private var content: String = "Hello World"
    @State private var sliderValue: Double = 0.4
    @State private var isToggleOn = false
    @State private var textColor: Color  = .white
    @State private var bgColor: Color  = .black
    @State private var overlayColor1: Color  = DataColor.hexToColor(hex: "59ced0")
    @State private var overlayColor2: Color  = DataColor.hexToColor(hex: "e44d71")
    @State private var showOverlayColor: Bool = false
    @State private var showStrokeColor: Bool = true
    @State private var strokeColor: Color = .red
    @State private var content: String = ""
    @State private var content1: String = "Hello World"
    @State private var isPresented = false
    @State private var currentDate: Int?
    @State private var showToast: Bool = false
    @State private var isActive = false
    
    @State private var duration: Double = 6.0
//    @AppStorage("isPurchased") var isPurchased: Bool = false
    @State var isPurchased: Bool = false
    private var colors: [String]
    private var colors2: [String]
    private var colors3: [String]
    private var colors4: [String]
    private var colors5: [String]
//    @ObservedObject var storeKit : StoreKitManager
    @ObservedObject var storeKit : StoreKitManager
//    @State private var isLoading = true
  
   
//    @State private var purchasedProductIdentifiers: Set<String> = []
    
    
    let items = Array(1...10)
    @State private var selectedColorIndex: Int? = nil
    @State private var selectedColorIndex2: Int? = nil
    @State private var selectedColorIndex3: Int? = nil
    @State private var selectedColorIndex4: Int? = nil
    
    
    
    init() {
        self.storeKit = StoreKitManager()
        colors = ["#ffffff", "#ed7979","#dc97be", "cd97dc",  "#9f97dc","#97c4dc", "#97dcc9",
                  "#97dcc9","#a9dc97",
                  "#bcdc97","#dadc97","#dcb397"
        ]
        colors2 = [
            "#000000","#ff0000", "#ff008a","#ff00f6", "a200ff",  "#2400ff","#0096ff", "#00f6ff","#00ff96","#00ff42","#84ff00","#eaff00","#ffc600","#ff7e00"
        ]
        colors3 = [
            "#000000","#ffffff", "#ff0000", "#ff008a","#ff00f6", "a200ff",  "#2400ff","#0096ff", "#00f6ff","#00ff96","#00ff42",
            "#84ff00","#eaff00","#ffc600","#ff7e00"
        ]
        
        colors4 = [
            "#59ced0","ff0000", "#e86e6e", "#68a6db"
        ]
        colors5 = [
            "#e44d71","#001eff", "#dbc968", "#ff008a"
        ]

        
        
    }
    
    
    
    func getCurrentDateNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        return month * 100 + day
    }
    
    func checkPurchases(product: Product) {
        Task {
            // 等待0.5秒
//            try? await Task.sleep(nanoseconds: 100_000_000) // 0.5秒
               // 执行第二次检查
            do {
               let purchased = try await storeKit.isPurchased(product)
               DispatchQueue.main.async {
                   print("Product2 \(product.id) purchased status (after delay): \(purchased)")
                   isPurchased = purchased
               }
            } catch {
               print("Failed2 to check purchase status for \(product.id) after delay: \(error)")
            }
        }
        
        
        
        
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                DataColor.hexToColor(hex: "18181b")
                GeometryReader { geometry in
                    VStack {
                        Spacer().frame(width: UIScreen.main.bounds.width,height: 100)
                        
                        
                        VStack {
                            // 使用 ForEach 显示产品列表
                            ForEach(storeKit.storeProducts) { product in
                                HStack {
                                    //                                Text(product.displayName)
                                    //                                Spacer()
                                    //                                Text(isPurchased ? "Purchased" : "Not Purchased")
                                    
                                }.onAppear {
                                    checkPurchases(product: product)
                                }
                            }
                        }
                        
                        //                    .background(.purple)
//                        if !isPurchased { ZStack{
//                            Spacer().frame(width: UIScreen.main.bounds.width,height: 60).background(DataColor.hexToColor(hex: "e9cfaf"))
//                            
//                            
//                            VStack{
//                                Spacer()
//                                
//                                
//                                
//                                
////                                NavigationLink(destination: ProSwiftUIView()) {
////                                    
////                                    HStack{
////                                        Spacer()
////                                        Image(systemName: "crown.fill")
////                                            .font(.system(size: 22))
////                                            .padding(.leading,-20)
////                                            .foregroundColor( DataColor.hexToColor(hex: "96724e"))
////                                        
////                                        Text("Pro")
////                                            .foregroundColor(DataColor.hexToColor(hex: "6d4f31"))
////                                            .font(.system(size: 20))
////                                            .padding(.all,0)
////                                        
////                                        Spacer()
////                                    }
////                                }
//                                
//                                
//                                
//                                Spacer()
//                            }.frame(width: UIScreen.main.bounds.width,height: 60)
//                            
//                        }
//                        }
                        
                        ZStack{
                            
                            Spacer().frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.width/16 * 9).background(bgColor)
                            
                            //65e4c2
                            // “”
                            VStack{
                                Spacer()
                                
                                if showOverlayColor {
                                    Text("\( content.isEmpty ? content1 : content )")
                                        .foregroundColor(textColor)
                                        .font(.system(size: CGFloat(Int(sliderValue*100))))
                                    
                                        .frame(maxWidth: .infinity)
                                    
                                        .padding(.all,0)
                                    //                                .shadow(color: strokeColor, radius: 1)
                                    //                                .shadow(color: strokeColor, radius: 1)
                                    //                                .shadow(color: strokeColor, radius: 1)
                                    //                                .shadow(color: strokeColor, radius: 1)
                                    //
                                        .shadow(color: overlayColor1.opacity(1), radius: 1, x: 1, y: 1)
                                        .shadow(color: overlayColor1.opacity(1), radius: 1, x: 1, y: 1)
                                        .shadow(color: overlayColor1.opacity(1), radius: 1, x: 1, y: 1)
                                        .shadow(color: overlayColor2.opacity(1), radius: 1, x: -1, y: -1)
                                        .shadow(color:overlayColor2.opacity(1), radius: 1, x: -1, y: -1)
                                    
                                        .shadow(color: overlayColor2.opacity(1), radius: 1, x: -1, y: -1)
                                } else {
                                    
                                    if showStrokeColor {
                                        Text("\(content.isEmpty ? content1 : content )")
                                            .foregroundColor(textColor)
                                            .font(.system(size: CGFloat(Int(sliderValue*100))))
                                        
                                            .frame(maxWidth: .infinity)
                                        
                                            .padding(.all,0)
                                            .shadow(color: strokeColor, radius: 1)
                                            .shadow(color: strokeColor, radius: 1)
                                            .shadow(color: strokeColor, radius: 1)
                                            .shadow(color: strokeColor, radius: 1)
                                    } else {
                                        Text("\(content)")
                                            .foregroundColor(textColor)
                                            .font(.system(size: CGFloat(Int(sliderValue*100))))
                                        
                                            .frame(maxWidth: .infinity)
                                        
                                    }
                                    
                                }
                                
                                
                                
                                //                            .shadow(color: .red,radius: 20)
                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.width/16 * 9)
                            
                            
                        }
                        
                        
                        HStack{
                            
                            
                            TextField("Please enter text",
                                      text: $content,
                                      onEditingChanged: { isEditing in
                                
                                UserDefaults.standard.set(content, forKey: "content")
                                // 可选：处理编辑状态变化
                                
                            },
                                      onCommit: {
                                
                                // 可选：处理提交动作
                            })
                            .foregroundColor(Color.black)
                            .border(Color.black, width: 0)
                            //                        .textFieldStyle(.roundedBorder)
                            .font(.system(size: 20)) // 设置文本的字体大小为20
                            .padding(.horizontal, 15) // 设置水平方向的内边距为20
                            .padding(.vertical, 10) // 设置垂直方向的内边距为10
                            .background(Color.white) // 设置白色背景
                            .cornerRadius(12) // 设置圆角
                            .padding()
                            .keyboardType(.default)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            //                        Text("\(UserDefaults.standard.integer(forKey: "clickCount2\(getCurrentDateNumber())"))")
                            
                            VStack {
                                Button {
//                                    if isPurchased {
//                                        isActive = true
//                                        return
//                                    }
//                                    
//                                    
//                                    if( UserDefaults.standard.integer(forKey: "clickCount2\(getCurrentDateNumber())") <= 2){
//                                        
//                                        //Code here before changing the bool value
//                                        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "clickCount2\(getCurrentDateNumber())") + 1, forKey: "clickCount2\(getCurrentDateNumber())")
//                                        isActive = true
//                                    } else{
//                                        showToast = true
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                                            showToast = false
//                                        }
//                                    }
//                                    
                                    isActive = true
                                    
                                } label: {
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 20)).padding(.trailing,0)
                                        .padding()
                                        .background(DataColor.hexToColor(hex: "6931c5"))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .padding(.all,0)
                                        .padding(.trailing,20)
                                }
                            }
                            .navigationDestination(isPresented: $isActive) {
                                LedView(content: $content,textColor:$textColor,
                                        bgColor:$bgColor,overlayColor1:$overlayColor1,
                                        overlayColor2:$overlayColor2,
                                        showOverlayColor:$showOverlayColor,
                                        showStrokeColor:$showStrokeColor,
                                        strokeColor:$strokeColor,
                                        sliderValue:$sliderValue,
                                        duration:$duration
                                )
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        ScrollView {
                            
                            
                            HStack{
                                Text("FontSize").padding(.leading, 20)
                                Slider(value: $sliderValue, in: 0...2, step: 0.1)
                                    .padding()
                                    .accentColor(DataColor.hexToColor(hex: "6931c5"))
                            }
                            
                            //                       // 显示滑块的值
                            //                       Text("滑块的值：\(sliderValue, specifier: "%.2f")")
                            //                           .padding()
                            HStack{
                                Text("FontColor").padding(.leading, 20)
                                Spacer()
                            }
                            
                            
                            ScrollView(.horizontal, showsIndicators: true) {
                                
                                HStack(spacing: 10) {
                                    ForEach(0..<colors.count, id: \.self) { index in
                                        let isSelected = index == selectedColorIndex
                                        Circle()
                                                                .fill(DataColor.hexToColor(hex: colors[index]))
                                                                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                                                                .frame(width: isSelected ? 40 : 30, height: isSelected ? 40 : 30) // 修改大小以显示选中状态
                                                                .overlay(
                                                                    Circle()
                                                                        .stroke( DataColor.hexToColor(hex: colors[index]), lineWidth: 4)
                                                                )
                                                                .onTapGesture {
                                                                    selectedColorIndex = index // 设置选中的颜色索引
                                                                    textColor = DataColor.hexToColor(hex: colors[index])
                                                                    saveColors()
                                                                }                                    }
                                }.padding()
                                
                                
                                
                                
                            }
                            .frame(height: 20) // 设置滚动视图的高度
                            .padding()
                            
                            
                            HStack{
                                Text("BackgroundColor").padding(.leading, 20)
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack(spacing: 10) {
                                    ForEach(0..<colors2.count, id: \.self) { index in
                                        let isSelected = index == selectedColorIndex2
                                        Circle()
                                            .fill(DataColor.hexToColor(hex: colors2[index]))
                                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                                            .frame(width: isSelected ? 40 : 30, height: isSelected ? 40 : 30)
                                            .transition(.scale)
                                        //                                           .border(hexToColor(hex: colors2[index]), width: 4)
                                            .onTapGesture {
                                                selectedColorIndex2 = index
                                                self.bgColor = DataColor.hexToColor(hex: colors2[index])
                                                saveColors()
                                                
                                            }.overlay(
                                                Circle().stroke(isSelected ? DataColor.hexToColor(hex: colors2[index]) : Color.clear, lineWidth: 4) // 仅在选中时显示边框
//                                                Circle()
//                                                    .stroke(DataColor.hexToColor(hex: colors2[index]), lineWidth: 4)
                                            )
                                    }
                                }.padding()
                            }
                            .frame(height: 20) // 设置滚动视图的高度
                            .padding()
                            
                            //                                            HStack{
                            //                                                Toggle("文字描边", isOn: $isToggleOn)
                            //                                                    .padding()
                            //                                                //                                  .labelsHidden() // 隐藏默认标签
                            //                                                    .toggleStyle(SwitchToggleStyle(tint: DataColor.hexToColor(hex: "6931c5")))
                            //
                            //                                            }
                            //                        //
                            
                            
                            HStack{
                                Text("Stroke Outline").padding(.leading, 20)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack(spacing: 10) {
                                    
                                    Image("noSelect") // 图片名称
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 36, height: 36) // 设置图片大小
                                    //                                      .clipShape(Circle()) // 可选：剪裁为圆形
                                        .onTapGesture {
                                            showStrokeColor = false
                                            showOverlayColor = false
                                        }
                                    ForEach(0..<colors3.count, id: \.self) { index in
                                        let isSelected = index == selectedColorIndex3
                                        Circle()
                                            .fill(DataColor.hexToColor(hex: colors3[index]))
                                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                                            .frame(width: isSelected ? 40 : 30, height: isSelected ? 40 : 30)
                                            .transition(.scale)
                                        //                                           .border(hexToColor(hex: colors2[index]), width: 4)
                                            .onTapGesture {
                                                selectedColorIndex3 = index
                                                self.strokeColor = DataColor.hexToColor(hex: colors3[index])
                                                showStrokeColor =  true
                                                showOverlayColor = false
                                                saveColors()
                                                
                                            }.overlay(
                                                Circle()
                                                    .stroke(DataColor.hexToColor(hex: colors3[index]), lineWidth: 4)
                                            )
                                    }
                                }.padding()
                            }
                            .frame(height: 20) // 设置滚动视图的高度
                            .padding()
                            
                            
                            
                            
                            HStack{
                                Text("Dual-Color Stroke Outline").padding(.leading, 20)
                                Spacer()
                            }
                            
                            
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack(spacing: 10) {
                                    Image("noSelect") // 图片名称
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 36, height: 36) // 设置图片大小
                                    //                                      .clipShape(Circle()) // 可选：剪裁为圆形
                                        .onTapGesture {
                                            saveColors()
                                            showOverlayColor = false
                                        }
                                    
                                    ForEach(0..<colors4.count, id: \.self) { index in
                                        let isSelected = index == selectedColorIndex4
                                        Circle()
                                            .fill(DataColor.hexToColor(hex: colors4[index]))
                                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                                            .frame(width: isSelected ? 40: 30, height:  isSelected ? 40: 30)
                                            .transition(.scale)
                                        //                                        .border(DataColor.hexToColor(hex: colors5[index]), width: 4)
                                            .onTapGesture {
                                                selectedColorIndex4 = index
                                                showStrokeColor = false
                                                showOverlayColor = true
                                                self.overlayColor1 = DataColor.hexToColor(hex: colors4[index])
                                                self.overlayColor2 = DataColor.hexToColor(hex: colors5[index])
                                                saveColors()
                                                //                                            self.themeColor = hexToColor(hex: colors2[index])
                                                
                                            }.overlay(
                                                Circle()
                                                    .stroke(DataColor.hexToColor(hex: colors5[index]), lineWidth: 4)
                                            )
                                    }
                                }.padding()
                            }
                            .frame(height: 20) // 设置滚动视图的高度
                            .padding()
                            
                            
                            HStack{
                                Text("Duration").padding(.leading, 20)
                                Slider(value: $duration, in: 0...20, step: 0.5)
                                    .padding()
                                    .accentColor(DataColor.hexToColor(hex: "6931c5"))
                                Text(String(duration))
                                Spacer().frame(width:10)
                            }.padding(.trailing, 20)
                            
                            Text("The longer the duration, the slower it moves; it won't move when it is zero.")
                            Spacer().frame(width: 100, height: 100).background(.red).opacity(0)
                            
                            
                            
                        }
                        
                        
                        
                        //                .background(.red)
                        //           18181b
                    }.foregroundColor(DataColor.hexToColor(hex: "e7eae4")).frame(width: geometry.size.width, height: geometry.size.height)
                    
                }
                
                if showToast {
                    Toast(message: "Limit generate to 2 times per day. exceeding the limit requires Pro!")
                    
                }
                
                
                VStack{
                    Spacer().frame(height: 50)
                    HStack{
                        Spacer()
                        NavigationLink(destination: SettingView()) {
                            Image(systemName: "gearshape")
                                .font(.system(size: 28)).padding(.trailing,20)
                                .foregroundColor( DataColor.hexToColor(hex: "6931c5"))
                            
                        }
                    }
                    
                    Spacer()
                }
                
            }
            //        .onAppear(){
            //            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            //
            //               windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
            //        }
//            .resetScale()
            .onAppear {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                UIScreen.main.fixedCoordinateSpace.disableAutoMatching()
//                if let window = UIApplication.shared.windows.first {
//                       window.contentScaleFactor = UIScreen.main.scale
//                   }
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                //            UINavigationController.attemptRotationToDeviceOrientation()
//                
//                UserDefaults.standard.set(content, forKey: "content")
//                UserDefaults.standard.set(textColor.toHexString(), forKey: "textColor")
//                UserDefaults.standard.set(bgColor.toHexString(), forKey: "bgColor")
//                UserDefaults.standard.set(overlayColor1.toHexString(), forKey: "overlayColor1")
//                UserDefaults.standard.set(overlayColor2.toHexString(), forKey: "overlayColor2")
//                UserDefaults.standard.set(strokeColor.toHexString(), forKey: "strokeColor")
//                UserDefaults.standard.set(String(sliderValue), forKey: "sliderValue")
//                UserDefaults.standard.set(showOverlayColor, forKey: "showOverlayColor")
//                UserDefaults.standard.set(showStrokeColor, forKey: "showStrokeColor")
//                
                
                
                if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
                    // iOS版本大于等于16.0，使用新的方法
                    UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
                } else {
                    // iOS版本小于16.0，使用旧的方法
                    //                UINavigationController.attemptRotationToDeviceOrientation()
                }
                
            }
           
            .onDisappear {
                
                 AppDelegate.orientationLock = .all
//                DispatchQueue.main.async {
//                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
//                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//                    // UINavigationController.attemptRotationToDeviceOrientation()
//                    //                UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
//                    if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
//                        // iOS版本大于等于16.0，使用新的方法
//                        UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
//                    } else {
//                        // iOS版本小于16.0，使用旧的方法
//                        //                        UINavigationController.attemptRotationToDeviceOrientation()
//                    }
//                    
//                }
            }
            
            
            .edgesIgnoringSafeArea(.all)
        }.navigationViewStyle(StackNavigationViewStyle())
        //
        
    }
    
    func saveColors() {
        
        UserDefaults.standard.set(content, forKey: "content")
        UserDefaults.standard.set(textColor.toHexString(), forKey: "textColor")
        UserDefaults.standard.set(bgColor.toHexString(), forKey: "bgColor")
        UserDefaults.standard.set(overlayColor1.toHexString(), forKey: "overlayColor1")
        UserDefaults.standard.set(overlayColor2.toHexString(), forKey: "overlayColor2")
        UserDefaults.standard.set(strokeColor.toHexString(), forKey: "strokeColor")
        UserDefaults.standard.set(String(sliderValue), forKey: "sliderValue")
        UserDefaults.standard.set(showOverlayColor, forKey: "showOverlayColor")
        UserDefaults.standard.set(showStrokeColor, forKey: "showStrokeColor")
        
        
    }
    
    
}



#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
