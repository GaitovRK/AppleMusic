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
            
        } catch {
            print("errorrrr")
        }
    }
}
