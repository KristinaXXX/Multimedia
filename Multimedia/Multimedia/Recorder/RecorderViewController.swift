//
//  RecorderViewController.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

class RecorderViewController: UIViewController {

    private let viewModel: RecorderViewModel
    
    private lazy var playButton = CustomButtonImage(image: "play.fill", width: 40, buttonAction: ( { self.playButtonPressed() } ))
    private lazy var recordButton = CustomButtonImage(image: "record.circle.fill", width: 40, buttonAction: ( { self.recordButtonPressed() } ))
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
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
        stackView.distribution = .fillProportionally
        //stackView.spacing = 20
        stackView.alignment = .center
        
        return stackView
    }()
    
    init(viewModel: RecorderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        
        viewModel.requestRecordPermission(completion: { [weak self] result in
            if !result {
                self?.recordButton.isEnabled = true
            }})
    }
    
    func addSubviews() {
        
        guard let imageDisabled = UIImage(systemName: "stop.fill") else { return }
        recordButton.setImage(imageDisabled.imageWith(newSize: CGSize(width: 40, height: 40)).withTintColor(.lightGray), for: .selected)
        playButton.setImage(imageDisabled.imageWith(newSize: CGSize(width: 40, height: 40)).withTintColor(.lightGray), for: .selected)

        view.backgroundColor = .systemGray6
        
        view.addSubview(durationLabel)
        view.addSubview(stackUserData)
   
        stackUserData.addArrangedSubview(recordButton)
        stackUserData.addArrangedSubview(playButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            durationLabel.heightAnchor.constraint(equalToConstant: 20),
            durationLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            durationLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),
            durationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            stackUserData.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 20),
            stackUserData.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackUserData.heightAnchor.constraint(equalToConstant: 50),
            stackUserData.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),
            stackUserData.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60)
        ])
        
    }
    
    func playButtonPressed() {
        if recordButton.isSelected {
            viewModel.finishRecording(success: true)
            recordButton.isSelected = false
        }
        viewModel.play()
        playButton.isSelected = !playButton.isSelected
    }
    
    func recordButtonPressed() {
        if recordButton.isSelected {
            viewModel.finishRecording(success: true)
            recordButton.isSelected = false
        } else {
            recordButton.isSelected = true
            viewModel.startRecording()
        }
    }
}
