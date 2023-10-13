//
//  RecorderViewModel.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import AVFoundation

final class RecorderViewModel {

    private let model: RecorderModel
    private let coordinator: RecorderCoordinatorProtocol
    
    private var player = AVAudioPlayer()
    private var recordingSession: AVAudioSession!
    private var whistleRecorder: AVAudioRecorder!
    
    var audioURL: URL?
    
    init(model: RecorderModel, coordinator: RecorderCoordinatorProtocol) {
        self.model = model
        self.coordinator = coordinator
    }
    
    func requestRecordPermission(completion: @escaping (Bool) -> Void) {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [weak self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                    } else {
                        self?.coordinator.showErrorRecorder("error")
                    }
                    completion(allowed)
                }
            }
        } catch {
            coordinator.showErrorRecorder("error")
        }
    }
    
    func play() {
        
        guard let audioURL = audioURL else { return }
        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player.prepareToPlay()
        }
        catch {
            coordinator.showErrorRecorder("error")
        }
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func startRecording() {
        audioURL = RecorderViewModel.getWhistleURL()
        print(audioURL!.absoluteString)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            whistleRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            //whistleRecorder.delegate = self
            whistleRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        whistleRecorder.stop()
        whistleRecorder = nil
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getWhistleURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
}
