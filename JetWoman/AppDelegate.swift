//
//  AppDelegate.swift
//  JetWoman
//
//  Created by Aleksandr Nikiforov on 21.05.2020.
//  Copyright © 2020 Aleksandr Nikiforov. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func resetScoreClicked(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "highscore")
        UserDefaults.standard.synchronize()
        if let viewController = NSApplication.shared.windows.first?.contentViewController as? ViewController {

            if let scene = viewController.skView.scene as? GameScene {
                scene.updateHighscore()
            }
        }
        
    }
    
}
