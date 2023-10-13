//
//  VideoViewController.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

class VideoViewController: UIViewController {

    private let viewModel: VideoViewModel
    
    private lazy var videoTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.id)
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    init(viewModel: VideoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        videoTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            videoTableView.deselectRow(
                at: indexPath,
                animated: animated
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        tuneTableView()
        
    }
    
    private func addSubviews() {
        view.addSubview(videoTableView)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            videoTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            videoTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            videoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            videoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.rowHeight = UITableView.automaticDimension
    }
}

extension VideoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videoCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.id, for: indexPath) as! VideoTableViewCell
        cell.update(viewModel.nameVideo(selectRow: indexPath.row))
        return cell
    }

}

extension VideoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showVideoPage(selectRow: indexPath.row)
    }
}


