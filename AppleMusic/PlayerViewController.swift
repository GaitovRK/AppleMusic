//
//  PlayerViewController.swift
//  AppleMusic
//
//  Created by Rashid Gaitov on 17.07.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet var playerView: UIView!
    
    let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    public var position = 0
    public var songs = [Song]()
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if playerView.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)

            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch {
            print("errorrrr")
        }
        
        albumCoverImageView.frame = CGRect(x: 10,
                                           y: 10,
                                           width: playerView.frame.size.width - 20,
                                           height: playerView.frame.size.width - 20)
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumCoverImageView.frame.size.height + 50,
                                     width: playerView.frame.size.width - 20,
                                     height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumCoverImageView.frame.size.height + 80,
                                       width: playerView.frame.size.width - 20,
                                       height: 70)
        
        albumCoverImageView.image = UIImage(named: song.cover)
        songNameLabel.text = song.name
        artistNameLabel.text = song.artist
        
        playerView.addSubview(albumCoverImageView)
        playerView.addSubview(songNameLabel)
        playerView.addSubview(artistNameLabel)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    
}
