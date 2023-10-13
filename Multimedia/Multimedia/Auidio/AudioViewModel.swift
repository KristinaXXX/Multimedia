//
//  AudioViewModel.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import AVFoundation

final class AudioViewModel {

    private let model: AudioModel
    private let coordinator: AudioCoordinatorProtocol
    private var player = AVAudioPlayer()
    private var tracks: [Track] = []
    private var selectedNumberTrack: Int!
    var selectedTrack: Track!
    
    init(model: AudioModel, coordinator: AudioCoordinatorProtocol) {
        self.model = model
        self.coordinator = coordinator
        loadData()
    }
    
    func loadData() {
        tracks = Track.make()
        selectedNumberTrack = 0
        selectedTrack = tracks[selectedNumberTrack]
        startPlayer()
    }
    
    func startPlayer() {
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: selectedTrack.fileURLWithPath))
            player.prepareToPlay()
        }
        catch {
            coordinator.showErrorPlay("error")
        }
    }
    
    func play() {
        if selectedNumberTrack == nil {
            selectedNumberTrack = 0
            selectedTrack = tracks[selectedNumberTrack]
        }
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func stop() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
    }
    
    func previousTrack() {
        let needPlayAfter = player.isPlaying
        selectedNumberTrack -= 1
        if selectedNumberTrack < 0 {
            selectedNumberTrack = 0
        }
        
        selectedTrack = tracks[selectedNumberTrack]
        startPlayer()
        if needPlayAfter {
            player.play()
        }
    }
    
    func nextTrack() {
        let needPlayAfter = player.isPlaying
        selectedNumberTrack += 1
        if selectedNumberTrack >= tracks.count {
            selectedNumberTrack = 0
        }
        
        selectedTrack = tracks[selectedNumberTrack]
        startPlayer()
        if needPlayAfter {
            player.play()
        }
    }
    
    func getInfoTrack() -> InfoTrack {
        
        var infoTrack = InfoTrack()
        let playerItem = AVPlayerItem(url: URL.init(fileURLWithPath: selectedTrack.fileURLWithPath))
        let metadataList = playerItem.asset.metadata
        for item in metadataList {

            guard let key = item.commonKey, let value = item.value else{
                continue
            }

           switch key {
               // не смогла вытащить из метаданных обложку трека (альбома), чтобы переключать UIImageView при смене трека
           case AVMetadataKey(rawValue: "title"): infoTrack.name = (value as? String)!
           case AVMetadataKey(rawValue: "artist"): infoTrack.artist = (value as? String)!
            default:
              continue
           }
        }
        return infoTrack
    }

}
