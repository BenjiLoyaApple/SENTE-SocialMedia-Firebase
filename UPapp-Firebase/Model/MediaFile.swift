//
//  Reels.swift
//  UPapp
//
//  Created by Benji Loya on 04/11/2022.
//

import SwiftUI

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
    
}

var MediaFileJSON = [
    MediaFile(url: "Reels1", title: "Emirates Mall beautifull collection..."),
    MediaFile(url: "Reels2", title: "NighLife in New York..."),
    MediaFile(url: "Reels3", title: "New Photo set..."),
    MediaFile(url: "Reels4", title: "Emirates mall world fashion..."),
    MediaFile(url: "Reels5", title: "Netflix - Wednesday..."),
    MediaFile(url: "Reels6", title: "Burj Khalifa views..."),
    MediaFile(url: "Reels7", title: "New York cool views..."),
    MediaFile(url: "Reels8", title: "Halloween..."),
    MediaFile(url: "Reels9", title: "How make Food in restaurant..."),
    MediaFile(url: "Reels10", title: "Dubai spa hotel in Marina beach..."),
]

/*
import SwiftUI
import FirebaseFirestoreSwift

//MARK: Reel Model
struct Reel: Identifiable,Codable,Equatable,Hashable {
    
    @DocumentID var id: String?
    var text: String
    var videoURL: URL?
    var videoReferenceID: String = ""
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
//    MARK: Basic User Info
    var userName: String
    var userUID: String
    var userProfileURL: URL
    var player: AVPlayer
    var mediaFile: MediaFile
    
    enum CodingKeys: CodingKey {
        case id
        case text
        case videoURL
        case videoReferenceID
        case publishedDate
        case likedIDs
        case userName
        case userUID
        case userProfileURL
        case player
        case mediaFile
        
    }
}
*/
