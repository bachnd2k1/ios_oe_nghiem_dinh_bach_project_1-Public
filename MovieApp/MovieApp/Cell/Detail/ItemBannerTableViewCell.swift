//
//  ItemBannerTableViewCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 25/09/2023.
//

import UIKit
import WebKit


final class ItemBannerTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var uiView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet private weak var desciptionLabel: UILabel!
    private var webView: WKWebView!
    private var movie: Movie?
    private var isExpanded = false
    private var baseURLVideo: String?
    
    @IBAction private func handlePlayButton(_ sender: Any) {

    }
    @IBAction private func handleSeeMoreButton(_ sender: Any) {
        isExpanded.toggle()
        desciptionLabel.numberOfLines = isExpanded ? 0 : 2
        seeMoreButton.isHidden = isExpanded
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        configUICell()
    }
    
    func configCell(endPointURL: String, movie: Movie) {
        self.movie = movie
        let path = EndPoint.baseVideoURL + endPointURL
        self.baseURLVideo = path
        guard let url = URL(string:path) else {return}
        webView.load(URLRequest(url: url))
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        desciptionLabel.text = movie.overview
    }
    
    private func configView() {
        webView = WKWebView(frame: uiView.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            webView.topAnchor.constraint(equalTo: uiView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configUICell() {
        playButton?.layer.cornerRadius = 5
    }
}

