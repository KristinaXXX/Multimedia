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
                viewController.tabBarItem = UITabBarItem(title: "Audio", image: UIImage(systemName: "rectangle.stack.fill"), tag: 0)
                coordinator.navigationController = navigationController
                navigationController.tabBarItem.title = "Audio"
                navigationController.setViewControllers([viewController], animated: true)
            case .video:
                let profileCoordinator = ProfileCoordinator()
                let factory = MyLoginFactory()
                let profileViewModel = ProfileViewModel(coordinator: profileCoordinator)
                profileViewModel.loginDelegate = factory.makeLoginInspector()
                let logInViewController = LogInViewController(profileViewModel: profileViewModel)
                logInViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)

                profileCoordinator.navigationController = navigationController
                navigationController.tabBarItem.title = "Profile"
                navigationController.setViewControllers([logInViewController], animated: true)
        }
    }
}
