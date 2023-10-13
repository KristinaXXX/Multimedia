//
//  Tracks.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import UIKit

struct Track {
    let fileURLWithPath: String
}


struct InfoTrack {
    var name: String = ""
    var artist: String = ""
}

extension Track {
    static func make() -> [Track] {
        var tracksArray: [Track] = []
        
        tracksArray.append(Track(fileURLWithPath: Bundle.main.path(forResource: "BurialUntrue", ofType: "mp3")!))
        tracksArray.append(Track(fileURLWithPath: Bundle.main.path(forResource: "CrystalCastlesCrimewave", ofType: "mp3")!))
        tracksArray.append(Track(fileURLWithPath: Bundle.main.path(forResource: "GorillazDare", ofType: "mp3")!))
        tracksArray.append(Track(fileURLWithPath: Bundle.main.path(forResource: "LanaDelReyBlueJeans", ofType: "mp3")!))        
        tracksArray.append(Track(fileURLWithPath: Bundle.main.path(forResource: "MassiveAttackParadiseCircus", ofType: "mp3")!))
        
        return tracksArray
    }
}
