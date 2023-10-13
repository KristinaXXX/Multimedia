//
//  FactoryTab.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

final class FactoryTab {
    enum Flow {
        case audio
        case video
        case recorder
    }
    
    private let flow: Flow
    let navigationController = UINavigationController()
    
    init(flow: Flow) {
        self.flow = flow
        startModule()
    }
    
    private func startModule() {
        switch flow {
            
        case .audio:
            let coordinator = AudioCoordinator()
            let model = AudioModel()
            let viewModel = AudioViewModel(model: model, coordinator: coordinator)
            let viewController = AudioViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Audio", image: UIImage(systemName: "playpause.fill"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Audio"
            navigationController.setViewControllers([viewController], animated: true)
        
        case .video:
            let coordinator = VideoCoordinator()
            let model = VideoModel()
            let viewModel = VideoViewModel(model: model, coordinator: coordinator)
            let viewController = VideoViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Video", image: UIImage(systemName: "play.tv.fill"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Video"
            navigationController.setViewControllers([viewController], animated: true)
            
        case .recorder:
            let coordinator = RecorderCoordinator()
            let model = RecorderModel()
            let viewModel = RecorderViewModel(model: model, coordinator: coordinator)
            let viewController = RecorderViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Recorder", image: UIImage(systemName: "recordingtape.circle.fill"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Recorder"
            navigationController.setViewControllers([viewController], animated: true)
        }
    }
}
