//
//  AudioCoordinator.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

protocol AudioCoordinatorProtocol {
    func showErrorPlay(_ text: String)
}

final class AudioCoordinator: AudioCoordinatorProtocol {
   
    var navigationController: UINavigationController?
    
    func showErrorPlay(_ text: String) {
        let alert = UIAlertController(title: "Error play", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
