//
//  PlayerCell.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 20/07/21.
//

import UIKit
import AVFoundation

class PlayerCell: UICollectionViewCell {

    var player: AVPlayer?
    static let identifier = "PlayerCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playVideoWithURL(url: String) {
        guard let videoURL = URL(string: url) else{return}
        player = AVPlayer(url: videoURL)
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerView)
        player?.play()
    }
    
}

