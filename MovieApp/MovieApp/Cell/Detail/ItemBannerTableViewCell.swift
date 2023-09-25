//
//  ItemBannerTableViewCell.swift
//  MovieApp
//
//  Created by Bach Nghiem on 25/09/2023.
//

import UIKit
import WebKit

protocol ItemBannerCellDelegate {
    func seeMoreTapped()
}

final class ItemBannerTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var uiView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet private weak var desciptionLabel: UILabel!
    private var webView: WKWebView!
    private var youtube: Youtube?
    private var movie: Movie?
    var delegate: ItemBannerCellDelegate?
    
    @IBAction private func handlePlayButton(_ sender: Any) {

    }
    @IBAction private func handleSeeMoreButton(_ sender: Any) {
        delegate?.seeMoreTapped()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        configUICell()
    }
    
    func configCell(youtube: Youtube, movie: Movie) {
        self.movie = movie
        self.youtube = youtube
        guard let url = URL(string: EndPoint.baseVideoURL + youtube.id.videoId) else {return}
        webView.load(URLRequest(url: url))
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
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

