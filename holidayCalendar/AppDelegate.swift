//
//  AppDelegate.swift
//  holidayCalendar
//
//  Created by Vera on 2021/11/1.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var interfaceOrientations:UIInterfaceOrientationMask = .portrait{
            didSet{
                //强制设置成竖屏
                if interfaceOrientations == .portrait{
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                              forKey: "orientation")
                }
                
            }
        }
    
    //返回当前界面支持的旋转方向
        func application(_ application: UIApplication, supportedInterfaceOrientationsFor
            window: UIWindow?)-> UIInterfaceOrientationMask {
            return interfaceOrientations
        }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

