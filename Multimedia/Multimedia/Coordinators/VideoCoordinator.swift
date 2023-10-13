//
//  VideoCoordinator.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

protocol VideoCoordinatorProtocol {
    func showVideo(video: Video)
}

final class VideoCoordinator: VideoCoordinatorProtocol {
   
    var navigationController: UINavigationController?
    
    func showVideo(video: Video) {
        navigationController?.pushViewController(DetailVideoViewController(url: video.url), animated: true)
    }
}
