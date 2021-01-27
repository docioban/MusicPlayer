//
//  SongViewController.swift
//  MusicPlayer
//
//  Created by Macbook Pro on 23.01.2021.
//

import UIKit
import AVFoundation

protocol PlayerDelegate {
    func didFetchPlayer(_ player: AVAudioPlayer, index: Int)
}

class SongViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var currentPlayer: AVAudioPlayer?
    var delegate: PlayerDelegate?
    var sliderTimer: Timer?
    
    var music: Music!
    var musics: [Music] = []
    var position: Int = 0
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    lazy var song: SongView = {
        let song = SongView(music: music)
        song.translatesAutoresizingMaskIntoConstraints = false
        return song
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if currentPlayer == nil {
            delegate?.didFetchPlayer(player!, index: position)
        }
    }
    
    func configure() {
        if player == nil {
            initSong()
        } else {
            sliderTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveSlider), userInfo: nil, repeats: true)
        }
        setVars()

        view.addSubview(song)
        setConstraints()
    }

    func setVars() {
        song.doneButton.addTarget(self, action: #selector(doneButtonTap), for: .touchUpInside)
        
        song.slider.addTarget(self, action: #selector(sliderChangeValue(_:)), for: .valueChanged)
        song.slider.addTarget(self, action: #selector(sliderFinishChangeValue(_:)), for: .touchUpInside)
        song.slider.addTarget(self, action: #selector(sliderCancelChangeValue(_:)), for: .touchUpOutside)
        
        song.playButton.addTarget(self, action: #selector(playButtonTap), for: .touchUpInside)
        
        song.changeBackButton.addTarget(self, action: #selector(changeBackButtonTap), for: .touchUpInside)
        song.changeForwardButton.addTarget(self, action: #selector(changeForwardButtonTap), for: .touchUpInside)
        
        guard let player = player else {
            return
        }
        
        song.nameLabel.text = music.name
        song.authorLabel.text = music.author
        song.image.image = UIImage(named: music.imageName ?? "default")
        song.playButton.setImage(player.isPlaying ? song.pauseIamge : song.playImage, for: .normal)
        let duration = Float(TimeInterval(player.duration))
        song.slider.maximumValue = duration
        song.slider.value = Float(player.currentTime)
        song.maxSliderValueLabel.text = "\(Int(duration)/60):\(String(format: "%02d", Int(duration)%60))"
    }

    func setConstraints() {
        song.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        song.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        song.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        song.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func initSong() {
            let urlString = Bundle.main.path(forResource: music.fileName, ofType: ".mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    fatalError("gdfgd")
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            } catch {
                fatalError("Error on search and opern file for play")
            }
            return
    }

    @objc func doneButtonTap() {
        dismiss(animated: true)
    }
    
    @objc func sliderChangeValue(_ sender: UISlider) {
        sliderTimer?.invalidate()
        song.sliderValueLabel.text = "\(Int(sender.value)/60):\(String(format: "%02d", Int(sender.value)%60))"
    }
    
    @objc func sliderFinishChangeValue(_ sender: UISlider) {
        guard let player = player else {
            return
        }
        player.currentTime = TimeInterval(sender.value)
        player.prepareToPlay()
        if player.isPlaying {
            player.play()
            sliderTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveSlider), userInfo: nil, repeats: true)
        }
    }
    
    @objc func sliderCancelChangeValue(_ sender: UISlider) {
        song.slider.setValue(Float(player?.currentTime ?? 00), animated: true)
    }
    
    @objc func playButtonTap() {
        guard let player = player else {
            return
        }
        if (currentPlayer != nil) {
            if currentPlayer != player {
                currentPlayer?.stop()
            }
            currentPlayer = nil
        }
        if player.isPlaying {
            song.playButton.setImage(song.playImage, for: .normal)
            player.stop()
            sliderTimer?.invalidate()
        } else {
            sliderTimer?.invalidate()
            sliderTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveSlider), userInfo: nil, repeats: true)
            player.play()
            song.playButton.setImage(song.pauseIamge, for: .normal)
        }
    }
    
    @objc func changeBackButtonTap() {
        if position > 0 {
            position -= 1
            music = musics[position]
            song.removeFromSuperview()
            player?.stop()
            player = nil
            configure()
        }
    }
    
    @objc func changeForwardButtonTap() {
        if position < musics.count - 1 {
            position += 1
            music = musics[position]
            song.removeFromSuperview()
            player?.stop()
            player = nil
            configure()
        }
    }
    
    @objc func moveSlider() {
        let currentTime = Float(player?.currentTime ?? 00)
        song.slider.value = currentTime
        song.sliderValueLabel.text = "\(Int(currentTime)/60):\(String(format: "%02d", Int(currentTime)%60))"
    }
}
