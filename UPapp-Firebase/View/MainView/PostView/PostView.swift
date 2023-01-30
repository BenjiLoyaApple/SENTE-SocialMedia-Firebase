//
//  PostView.swift
//  UPapp
//
//  Created by Benji Loya on 26/12/2022.
//

import SwiftUI

struct PostView: View {
    @State private var recentsPosts: [Post] = []
    
    var body: some View {
        NavigationStack {
            
            ReusablePostsView(posts: $recentsPosts)
                .hAlign(.center).vAlign(.center)
            
                .navigationBarItems(
                    leading:
                        Button {

                        } label: {
                            Text("sente")
                                .font(.title)
//                            Image("insta1")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 180, height: 50)
                                .foregroundColor(.accentColor)
                        }
                    ,
                    trailing:
                        NavigationLink(
                            destination: CreateNewPost{ post in
                                /// - Adding Created post at the Top of the Recent posts
                                recentsPosts.insert(post, at: 0)
                            },
                        label: {
                            Image(systemName: "plus.square")
                                .font(.callout)
                                .foregroundColor(.accentColor)
                        })
                )
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
