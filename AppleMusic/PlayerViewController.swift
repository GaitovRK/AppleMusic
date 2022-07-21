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
    let playPauseButton = UIButton()

    
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
                                     y: albumCoverImageView.frame.size.height + 20,
                                     width: playerView.frame.size.width - 20,
                                     height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumCoverImageView.frame.size.height + 50,
                                       width: playerView.frame.size.width - 20,
                                       height: 70)
        
        albumCoverImageView.image = UIImage(named: song.cover)
        songNameLabel.text = song.name
        artistNameLabel.text = song.artist
        
        playerView.addSubview(albumCoverImageView)
        playerView.addSubview(songNameLabel)
        playerView.addSubview(artistNameLabel)
        
        let nextButton = UIButton()
        let previousButton = UIButton()
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        previousButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        previousButton.tintColor = .black
        
        let centerX = (playerView.frame.size.width - 40)/2
        let buttonSize: CGFloat = 35

        playPauseButton.frame = CGRect(x: centerX,
                                       y: artistNameLabel.frame.maxY + 40,
                                       width: buttonSize,
                                       height: buttonSize)
        nextButton.frame = CGRect(x: centerX + 60,
                                  y: artistNameLabel.frame.maxY + 40,
                                  width: buttonSize,
                                  height: buttonSize)
        previousButton.frame = CGRect(x: centerX - 60,
                                      y: artistNameLabel.frame.maxY + 40,
                                      width: buttonSize,
                                      height: buttonSize)
        
        playerView.addSubview(playPauseButton)
        playerView.addSubview(nextButton)
        playerView.addSubview(previousButton)
        
        let slider = UISlider(frame: CGRect(x: 30,
                                            y: albumCoverImageView.frame.size.height + 120,
                                            width: playerView.frame.size.width - 60,
                                            height: 30))
        playerView.addSubview(slider)
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
    }
    
    @objc func didTapPlayPauseButton() {
        
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }

    }
    
    @objc func didTapNextButton() {
        if position == (songs.count - 1) {
            position = 0
        } else {
            position += 1
        }
        configure()
    }
    
    @objc func didTapPreviousButton() {
        if position == 0 {
            position = (songs.count - 1)
        } else {
            position -= 1
        }
        configure()
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    
}
