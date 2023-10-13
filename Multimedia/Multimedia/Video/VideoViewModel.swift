//
//  VideoViewModel.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation

final class VideoViewModel {
    
    private var videos: [Video]

    private let model: VideoModel
    private let coordinator: VideoCoordinatorProtocol
    
    init(model: VideoModel, coordinator: VideoCoordinatorProtocol) {
        self.model = model
        self.coordinator = coordinator
        videos = Video.make()
    }
    
    func videoCount() -> Int {
        videos.count
    }
    
    func selectVideo(selectRow: Int) -> Video {
        videos[selectRow]
    }
    
    func nameVideo(selectRow: Int) -> String {
        selectVideo(selectRow: selectRow).fullName
    }
    
    func showVideoPage(selectRow: Int) {
        let selectVideo = selectVideo(selectRow: selectRow)
        coordinator.showVideo(video: selectVideo)
    }
}
