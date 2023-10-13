//
//  AudioViewController.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

class AudioViewController: UIViewController {

    private let viewModel: AudioViewModel

    private lazy var playButton = CustomButtonImage(image: "play.fill", width: 40, buttonAction: ( { self.playButtonPressed() } ))
    private lazy var stopButton = CustomButtonImage(image: "stop.fill", width: 40, buttonAction: ( { self.stopButtonPressed() } ))
    private lazy var previousTrackButton = CustomButtonImage(image: "backward.fill", width: 60, buttonAction: ( { self.previousTrackButtonPressed() } ))
    private lazy var nextTrackButton = CustomButtonImage(image: "forward.fill", width: 60, buttonAction: ( { self.nextTrackButtonPressed() } ))
    
    private lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.layer.cornerRadius = 30
        albumImage.clipsToBounds = true
        albumImage.image = UIImage(named: "album")
        return albumImage
    } ()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackUserData: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.sizeToFit()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    init(viewModel: AudioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        viewModel.loadData()
        showInfoTrack()
    }
    
    func showInfoTrack() {
        let infoTrack = viewModel.getInfoTrack()
        authorLabel.text = infoTrack.artist
        fullNameLabel.text = infoTrack.name
    }
    
    func addSubviews() {
        
        guard let imageDisabled = UIImage(systemName: "pause.fill") else { return }
        playButton.setImage(imageDisabled.imageWith(newSize: CGSize(width: 40, height: 40)).withTintColor(.lightGray), for: .selected)
        
        view.backgroundColor = .systemGray6
        view.addSubview(albumImage)
        
        view.addSubview(fullNameLabel)
        view.addSubview(authorLabel)
        
        view.addSubview(stackUserData)
   
        stackUserData.addArrangedSubview(previousTrackButton)
        stackUserData.addArrangedSubview(playButton)
        stackUserData.addArrangedSubview(stopButton)
        stackUserData.addArrangedSubview(nextTrackButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        let width = safeAreaLayoutGuide.layoutFrame.width - 80
        
        NSLayoutConstraint.activate([
            albumImage.heightAnchor.constraint(equalToConstant: width),
            albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor),
            albumImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            albumImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            fullNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            fullNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 20),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),
            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            authorLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            stackUserData.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            stackUserData.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackUserData.heightAnchor.constraint(equalToConstant: 50),
            stackUserData.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),
            stackUserData.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60)
        ])
        
    }
    
    func playButtonPressed() {
        viewModel.play()
        playButton.isSelected = !playButton.isSelected
    }
    func stopButtonPressed() {
        viewModel.stop()
        playButton.isSelected = false
    }
    func previousTrackButtonPressed() {
        viewModel.previousTrack()
        showInfoTrack()
    }
    func nextTrackButtonPressed() {
        viewModel.nextTrack()
        showInfoTrack()
    }

}
