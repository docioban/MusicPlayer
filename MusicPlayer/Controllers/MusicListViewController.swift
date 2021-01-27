//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Macbook Pro on 17.01.2021.
//

import UIKit
import AVFoundation

class MusicListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayerDelegate {
    
    
    var musicList: [Music]!
    var player: AVAudioPlayer?
    var indexIsPlaing: Int?
    
    let table: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.image = UIImage(systemName: "pause")
        
        setupMusic()
        
        setTable()
    }
    
    func setupMusic() {
        if let path = Bundle.main.url(forResource: "MusicList", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path)
                if let jsonResult = try? JSONDecoder().decode(MusicList.self, from: jsonData) {
                    musicList = jsonResult.music
                }
            } catch {
                print(error)
            }
        }
    }
    
    func setTable() {
        view.addSubview(table)
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        table.separatorStyle = .none
        table.register(MusicTableViewCell.self, forCellReuseIdentifier: "musicCell")
        
        table.dataSource = self
        table.delegate = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as? MusicTableViewCell else {
            fatalError("No detect MusicTableViewCell")
        }
        cell.titleLabel.text = musicList[indexPath.row].name
        cell.authorLabel.text = musicList[indexPath.row].author
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(identifier: "Song") as? SongViewController {
            
            if indexPath.row == indexIsPlaing {
                viewController.player = player
            }
            
            viewController.music = musicList[indexPath.row]
            viewController.musics = musicList
            viewController.position = indexPath.row
            viewController.delegate = self
            if player != nil {
                viewController.currentPlayer = player
            }
            present(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func didFetchPlayer(_ player: AVAudioPlayer, index: Int) {
        self.player = player
        self.indexIsPlaing = index
    }
}

