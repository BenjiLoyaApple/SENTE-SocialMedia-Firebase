//
//  ReusableProfileContent.swift
//  UPapp
//
//  Created by Benji Loya on 15/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct ReusableProfileContent: View {
    var user: User
    
    @State var EditProfileSheet: Bool = false
    
    @State private var fetchedPosts: [Post] = []
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                HStack(spacing: 12){
                    WebImage(url: user.userProfileURL).placeholder{
//   MARK: Placeholder image
                        Image("nullProfile")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    
                    Spacer()
                }
                .padding(.horizontal)
                    //                    .frame(width: 80, height: 80)
                    //                    .cornerRadius(40)
                    //                    .frame(width: 82, height: 82)
                    //                    .background(Color.gray)
                    //                    .cornerRadius(42)
                    //                    .overlay(
                    //                        Circle()
                    //                            .fill(Color.blue)
                    //                            .frame(width: 25, height: 25)
                    //                            .padding(1)
                    //                            .background(Color.white)
                    //                            .cornerRadius(13)
                    //                            .overlay(
                    //                                Text("+")
                    //                                    .font(.title3)
                    //                                    .fontWeight(.bold)
                    //                                    .foregroundColor(.white)
                    //                            )
                    //                        , alignment: .bottomTrailing)
                    
                    
//  MARK: PROFILE INFO
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .font(.callout)
//                                Text(user.userfullname)
//                                Text("Digital Creator") // - description
                                Text(user.userBio)
                                
 //  MARK: Displaying Bio Link, if given while signing up profile page
                                if let bioLink = URL(string: user.userBioLink){
                                    Link(user.userBioLink, destination: bioLink)
                                        .font(.footnote)
                                        .tint(.blue)
                                        .lineLimit(1)
                                }
                            }
                            .font(.footnote)
                            
                            Spacer()
                        }
//    MARK: BUTTONS
//                                                HStack {
//                                                    Button(action: {
//                                                        EditProfileSheet.toggle()
//                                                    }, label: {
//                                                        Text("Edit profile")
//                                                            .font(.callout)
//                                                            .fontWeight(.regular)
//                                                            .frame(maxWidth: .infinity)
//                                                            .foregroundColor(.accentColor)
//                                                            .padding(8)
//                                                            .padding(.horizontal, 10)
//                                                            .background(Color("ButtonColor"))
//                                                            .cornerRadius(6)
//                                                    })
//                                                    .fullScreenCover(isPresented: $EditProfileSheet, content: {
//                                                        EditProfileScreen()
//                                                        .presentationDetents([.large])
//                                                        .presentationDragIndicator(.hidden)
//                                                        .ignoresSafeArea(.all)
//                                                                })
//                                                }
                    }
                    .padding(.horizontal)
                
                
 
                
                ReusablePostsView(basedOnUId: true, uid: user.userUID, posts: $fetchedPosts)
                    .padding(.top,20)
            }
        }
    }
}
