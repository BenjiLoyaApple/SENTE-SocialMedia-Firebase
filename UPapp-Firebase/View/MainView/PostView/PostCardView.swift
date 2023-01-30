//
//  PostCardView.swift
//  UPapp
//
//  Created by Benji Loya on 27/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct PostCardView: View {
    var post: Post
    /// - Callbacks
    var onUpdate: (Post)->()
    var onDelete: ()->()
    /// - View Properties
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    @State private var showComments: Bool = false
    @State private var expandImages: Bool = false
    @State private var pageIndex: Int = 0
    
    //    GESTURE IMAGE
    @State var currentAmount: CGFloat = 0
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
//        MARK: Avatar & userName + Button Delete
            HStack{
                WebImage(url: post.userProfileURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    
                
                Text(post.userName)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Spacer()
                
                        /// - Displaying Delete Button (if Author of that post)
                        if post.userUID == userUID{
                            Menu{
                                Button("Delete Post",role: .destructive,action: deletePost)
                            }label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.accentColor)
                                    .padding(8)
                                    .contentShape(Rectangle())
                            }
                        }
            }
            .padding(.horizontal, 5)
        
//        MARK: Image
        
            VStack(alignment: .leading, spacing: 3){
                /// - Post Image if Any
                if !post.imageURLs.isEmpty{
                    TabView(selection: $pageIndex){
                        ForEach(post.imageURLs,id: \.self){url in
                            let index = post.imageURLs.indexOf(url)
                            GeometryReader{
                                let size = $0.size
                                WebImage(url: url,options: [.scaleDownLargeImages,.lowPriority])
                                    .purgeable(true)
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 450)
                                    .clipShape(RoundedRectangle(cornerRadius: 0))
                                    .hAlign(.center)
                            }
                            .tag(index)
                            .frame(height: 450)
                            .onReceive(timer, perform: { _ in
                                withAnimation(.easeIn) {
                                    pageIndex = pageIndex == 1 ? 0 : pageIndex + 1
                                }
                            })
//                            .onTapGesture {
//                                looking image full screen
//                                expandImages.toggle()
//                                pageIndex = index
//                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 450)
                    .fullScreenCover(isPresented: $expandImages) {
                        ExpandedImagesView(imageURLs: post.imageURLs, pageIndex: $pageIndex)
                    }
                }
//                MARK: Likes
                
                PostInteraction()
                
//                MARK: Description
                HStack{
                    Text("\(post.userName) ")
                        .font(.system(size: 13))
                        .fontWeight(.medium)
                    +
                    Text(post.text)
                        .font(.system(size: 13))
                        .fontWeight(.light)
                }
                .padding(.horizontal)
                
                Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                    .padding(.horizontal)
            }
        .hAlign(.leading)
        .sheet(isPresented: $showComments, content: {
            CommentView(post: post)
                .presentationDragIndicator(.visible)
        })
        .onAppear{
            /// - Adding Only Once
            if docListner == nil{
                guard let postID = post.id else{return}
                docListner = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({ snapshot, error in
                    if let snapshot {
                        if snapshot.exists{
                            /// - Document Updeted
                            /// - Fetching Updated Document
                            if let updatedPost = try? snapshot.data(as: Post.self){
                                onUpdate(updatedPost)
                            }
                        }else{
                            /// - Document Deleted
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
//            MARK: Applying ShapShot listner Only when the post is available on the screen
//            Else removing the lister (it saves unwanted live updates from the posts whitch was swiped away from the screen)
            if let docListner{
                docListner.remove()
                self.docListner = nil
            }
        }
    }
               
               
    
//    MARK: Like/Dislike Interation
    @ViewBuilder
    func PostInteraction()->some View{
        HStack(spacing: 10){
            Button(action: likePost){
                Image(systemName: post.likedIDs.contains(userUID) ? "heart.fill" : "heart")
            }
            
            Button(action: {showComments.toggle()}) {
                Image(systemName: "message")
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
            }
      /*
            Button(action: dislikePost) {
                Image(systemName: post.dislikedIDs.contains(userUID) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
            }
            .padding(.leading, 25)

            Text("\(post.dislikedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
       */
        }
        .foregroundColor(.accentColor)
        .padding(.top,8)
        .padding(.bottom,2)
        .padding(.horizontal)
        
        Text("\(post.likedIDs.count) likes")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.accentColor)
            .padding(.horizontal)
    }
    
    /// - Liking Post
    func likePost(){
        Task{
            guard let postID = post.id else{return}
            if post.likedIDs.contains(userUID){
                /// - Removing User ID From the Array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                  "likedIDs": FieldValue.arrayRemove([userUID])
                ])
            }else{
                /// - Adding User ID to Liked Array and removing our ID from Disliked Array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayUnion([userUID]),
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    /*
    /// - Dislike Post
    func dislikePost(){
        Task{
            guard let postID = post.id else{return}
            if post.dislikedIDs.contains(userUID){
                /// - Removing User ID From the Array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }else{
                /// - Adding User ID to Liked Array and removing our ID from Disliked Array
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayUnion([userUID]),
                    "likedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    */
    
    /// - Deleting Post
    func deletePost(){
        Task{
            /// Step 1: Delete Image from Firebase Storage if present
            do{
                for id in post.imageReferenceIDs{
                    try await Storage.storage().reference().child("Post_Images").child(id).delete()
                }
                /// Step 2: Delete Firestore Document
                guard let postID = post.id else{return}
                try await Firestore.firestore().collection("Posts").document(postID).delete()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension [URL]{
    func indexOf(_ url: URL)->Int{
        if let index = self.firstIndex(of: url){
            return index
        }
        return 0
    }
}
