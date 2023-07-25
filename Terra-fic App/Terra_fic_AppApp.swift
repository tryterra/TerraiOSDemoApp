//
//  Terra_fic_AppApp.swift
//  Terra-fic App
//
//  Created by Elliott Yu on 30/03/2023.
//

import SwiftUI


@main
struct Terra_fic_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    print(url)
                }
        }
    }
}
