//
//  MainTabBarController.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let audioFactory = FactoryTab(flow: .audio)
    private let videoFactory = FactoryTab(flow: .video)
    private let recorderFactory = FactoryTab(flow: .recorder)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            audioFactory.navigationController,
            videoFactory.navigationController,
            recorderFactory.navigationController
        ]
        
        selectedIndex = 0
        tabBar.backgroundColor = .systemGray6
    }
}
