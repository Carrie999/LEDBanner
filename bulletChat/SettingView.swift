//
//  SettingView.swift
//  bulletChat
//
//  Created by  玉城 on 2024/5/7.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @State private var isShowingMailView = false
    @State private var isShowingActivityView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("isPurchased") var isPurchased: Bool = false
    
    
    func getAppShareText() -> String {
          // Customize the share text with your app's description
          return "Check out this amazing LED Banner app! It's the best app ever!"
      }
    func getAppStoreLink() -> URL {
            // Replace "your_app_id" with your actual App Store ID
            let appStoreID = "6502876372"
            let appStoreURL = "https://apps.apple.com/app/id\(appStoreID)"
            return URL(string: appStoreURL)!
        }
    var body: some View {
           
            ZStack{
//                if isIOSVersionGreaterThan(version: "17.0") {
//                    DataColor.hexToColor(hex: "000000")
//                }
               
               
                VStack(alignment: .leading, spacing: 10) {
                    Spacer().frame(height: 50)
//                        .background( DataColor.hexToColor(hex: "000000"))
           
//                        Color.black
                        VStack{
                            List {
                                Section(header: Text("").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)) {
                                   
                                        NavigationLink(destination: ProSwiftUIView()) {
                                            Text(isPurchased ?"Pro User" :"Tip").foregroundColor( DataColor.hexToColor(hex:isPurchased ? "ea9fe6" : "6931c5")).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                           


                                    Button(action: {
                                        Task {
                                   
                                            try? await AppStore.sync()
                                        }
             
                                    }) {
                                        Text("Restore Purchase")
                                    }

                                    Button(action: {
                                        if let url = URL(string: "itms-apps://itunes.apple.com/app/6502876372?action=write-review"),

                                            UIApplication.shared.canOpenURL(url){

                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)

                                        }


                                    }) {
                                        Text("Rate app")

                                    }

                                    //                    Text("建议吐槽")

                                    Button(action: {
                                        // 分享给朋友的操作

                                        self.isShowingActivityView = true


                                    }) {
                                        Text("Share app")
                                    }   .sheet(isPresented: $isShowingActivityView, content: {
                                        ActivityViewController(activityItems: [self.getAppShareText(), self.getAppStoreLink()])

                                    })
                                    sendMailSwiftUIView()



                                }
//                                .listRowBackground(Color.black)
                                //                    .listRowSeparator(.visible) // 显示分隔线
//                                .listRowSeparatorTint(Color.white.opacity(1)) // 设置分隔线颜色为红色
                                //                    .background(Color.black) // 设置列表的背景颜色为黑色
                                //                    .foregroundColor(Color.white) // 设置列表中文字的颜色为白色
                                //                    .foregroundColor( DataColor.hexToColor(hex:"494949"))
                                .padding()




                            }
                            //                .listStyle(InsetGroupedListStyle())
                            //                .listStyle(DefaultListStyle())
                            .listStyle(PlainListStyle()) // 设置列表样式
    //                        .listStyle(.plain) /
    //                        .listStyle(InsetGroupedListStyle())
//                            .background(Color.black) // 设置列表的背景颜色为黑色
//                            .foregroundColor(Color.white.opacity(1)) // 设置列表中文字的颜色为白色

                        }
                    
                    
                    Spacer()
                    
                }.multilineTextAlignment(.leading) 
                
                
                VStack{
                    Spacer()
                    Text("version(v1.0.7) ").foregroundColor( DataColor.hexToColor(hex:"494949")).opacity(0.5)
                    Spacer().frame(height: 50)
                }
                
                
                
                
                
                VStack{
                    Spacer().frame(height: 40)
                    HStack(alignment: .center,spacing:20){
                        
                        
                        Image(systemName:"chevron.backward")
                            .fontWeight(.bold)
                            .opacity(0.6)
//                            .font(.system(size: 24))
//                            .padding(.leading,20)
//                            .padding(.top,20)
                            .frame(width: 60, height:60)
                            .background(DataColor.hexToColor(hex:"6931c5"))
                            .cornerRadius(12)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }.shadow(color: Color.white.opacity(0.2), radius: 2, x: 0, y: 2)
                            .foregroundColor(.white)
                        Spacer()
                        
                    }
                    Spacer()
                    
                }
            }
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
                AppDelegate.orientationLock = .all
//                DispatchQueue.main.async {
//                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                    // UINavigationController.attemptRotationToDeviceOrientation()
//    //                UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
//                    if isIOSVersionGreaterThanOrEqualTo(version: "16.0") {
//                            // iOS版本大于等于16.0，使用新的方法
//                            UINavigationController().setNeedsUpdateOfSupportedInterfaceOrientations()
//                        } else {
//                            // iOS版本小于16.0，使用旧的方法
////                            UINavigationController.attemptRotationToDeviceOrientation()
//                        }
//                    
//                }
            }
        
            .scrollDisabled(true)

        .navigationBarHidden(true)
        .ignoresSafeArea(.all)
    }
    
}

struct ActivityViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Do nothing
    }
}


#Preview {
    SettingView()
}

