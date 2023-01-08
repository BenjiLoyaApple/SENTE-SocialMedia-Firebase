//
//  Reel.swift
//  UPapp
//
//  Created by Benji Loya on 04/11/2022.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {

    var id = UUID().uuidString
    var player: AVPlayer
    var mediaFile: MediaFile
}
     
