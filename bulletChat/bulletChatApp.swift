//
//  bulletChatApp.swift
//  bulletChat
//
//  Created by  玉城 on 2024/5/7.
//

import SwiftUI
import SwiftData


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("app delegate")
        return true
    }
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        return .all
//    }
//    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("app did enter background")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("app will terminate")
    }
    
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

@main
struct bulletChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBar(hidden: true)
        }
        
//        .modelContainer(sharedModelContainer)
    }
}
