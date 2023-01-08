//
//  MainView.swift
//  UPapp
//
//  Created by Benji Loya on 15/12/2022.
//

/*
 import SwiftUI

 struct MainView: View {
     
     @State var currentTab = "house"
     
     init() {
         UITabBar.appearance().isHidden = true
     }
     
     var body: some View {
         
             VStack(spacing: 0) {
                 TabView (selection: $currentTab) {
                     
                     PostView()
                         .tag("house")
                     
                     
                     SearchUserView()
                         .tag("magnifyingglass")
                         .navigationBarHidden(false)
                     
                     
//                     ReelsView()
//                         .tag("reels-icon")
//                         .navigationBarHidden(true)
                     
                     
                     Text("Notifications")
                         .tag("heart")
                         .navigationBarHidden(true)
                     
                     ProfileView()
                             .tag("person.circle")
                             .navigationBarHidden(true)
                         
                 }
                    
                     HStack(spacing: 0) {
                         
                         ForEach(["house","magnifyingglass","reels-icon","heart","person.circle"], id: \.self) { image in
                             
                             TabBarButton(image: image, isSystemImage: image != "reels-icon", currentTab: $currentTab)
                            
                         }
                         
                     }
                     .padding(.horizontal)
                     .padding(.vertical, 10)
                     .overlay(Divider(), alignment: .top)
                     .background(currentTab == "reels-icon" ? .black : .clear)
                     
                 }
         }
     }
     
     
     struct HomeView_Previews: PreviewProvider {
         static var previews: some View {
             ContentView()
         }
     }

   
 // MARK: TABBAR BUTTONS
     struct TabBarButton: View {
         
         var image: String
         var isSystemImage: Bool
         @Binding var currentTab: String
         
         var body: some View {
             Button {
                 withAnimation{currentTab = image}
             } label: {
                 
                 ZStack {
                     if isSystemImage {
                         Image(systemName: image)
                             .font(.title2)
                     }
                     else {
                         Image(image)
                             .resizable()
                             .renderingMode(.template)
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 25, height: 25)
                     }
                 }
                 .foregroundColor(currentTab == image ? currentTab == "reels-icon" ? .white : .primary : .gray)
                 .frame(maxWidth: .infinity)
             }
         }
     }
*/

import SwiftUI

struct MainView: View {
    var body: some View {
//        MARK: TabView with recent post's and profile tabs
        
        TabView{
            PostView()
                .tabItem{
                    Image(systemName: "house")
                }
            
            SearchUserView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
            
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person.circle")
                }
        }
//        Canging Tab Lable Tint To Black
        .tint(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
