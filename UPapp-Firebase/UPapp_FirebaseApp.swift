//
//  UPapp_FirebaseApp.swift
//  UPapp-Firebase
//
//  Created by Benji Loya on 08/01/2023.
//

import SwiftUI
import Firebase

@main
struct TheFirstSMApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
