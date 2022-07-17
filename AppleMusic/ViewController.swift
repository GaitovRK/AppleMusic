//
//  ViewController.swift
//  AppleMusic
//
//  Created by Rashid Gaitov on 17.07.2022.
//

import UIKit

struct Song {
    var name: String
    var artist: String
    var cover: String
    var trackName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.delegate = self
        table.dataSource = self
    
        configureSongs()
    }
    
    func configureSongs() {
        songs.append(Song(name: "Counting Stars",
                          artist: "One Republic",
                          cover: "oneRepublicCover",
                          trackName: "trackCountingStars"))
        songs.append(Song(name: "Smells Like Teen Spirit",
                          artist: "Nirvana",
                          cover: "nirvanaCover",
                          trackName: "trackSmellsLikeTeenSpirit"))
        songs.append(Song(name: "Группа Крови",
                          artist: "Кино",
                          cover: "tsoyCover",
                          trackName: "trackGruppaKrovi"))
        songs.append(Song(name: "Counting Stars",
                          artist: "One Republic",
                          cover: "oneRepublicCover",
                          trackName: "trackCountingStars"))
        songs.append(Song(name: "Smells Like Teen Spirit",
                          artist: "Nirvana",
                          cover: "nirvanaCover",
                          trackName: "trackSmellsLikeTeenSpirit"))
        songs.append(Song(name: "Группа Крови",
                          artist: "Кино",
                          cover: "tsoyCover",
                          trackName: "trackGruppaKrovi"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        cell.imageView?.image = UIImage(named: song.cover)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

