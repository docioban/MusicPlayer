//
//  Song.swift
//  MusicPlayer
//
//  Created by Macbook Pro on 25.01.2021.
//

import UIKit
import AVFoundation

class SongView: UIView {
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let sliderValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "0:00"
        return label
    }()
    
    let maxSliderValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    // MARK:- Controll Buttons
    let songControllViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let changeBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward.end"), for: .normal)
        return button
    }()
    
    let changeForwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.end"), for: .normal)
        return button
    }()
    
    let pauseIamge: UIImage = {
        let image = UIImage(systemName: "pause")
        return image!
    }()
    
    let playImage: UIImage = {
        let image = UIImage(systemName: "play")
        return image!
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shuffleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "shuffle"), for: .normal)
        return button
    }()
    
    let repeatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        return button
    }()
    
    init(music: Music) {
        super.init(frame: .zero)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {
        addSubview(doneButton)
        doneButton.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true

        addSubview(image)
        image.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true

        addSubview(slider)
        slider.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        slider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        
        addSubview(sliderValueLabel)
        sliderValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        sliderValueLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor).isActive = true
        
        addSubview(maxSliderValueLabel)
        maxSliderValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        maxSliderValueLabel.trailingAnchor.constraint(equalTo: slider.trailingAnchor).isActive = true
        
        addSubview(songControllViews)
        songControllViews.heightAnchor.constraint(equalToConstant: 50).isActive = true
        songControllViews.widthAnchor.constraint(equalTo: slider.widthAnchor).isActive = true
        songControllViews.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20).isActive = true
        songControllViews.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        songControllViews.addSubview(playButton)
        playButton.heightAnchor.constraint(equalTo: songControllViews.heightAnchor).isActive = true
        playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: songControllViews.topAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: songControllViews.centerXAnchor).isActive = true
        
        songControllViews.addSubview(changeBackButton)
        changeBackButton.heightAnchor.constraint(equalTo: songControllViews.heightAnchor).isActive = true
        changeBackButton.widthAnchor.constraint(equalTo: changeBackButton.heightAnchor).isActive = true
        changeBackButton.topAnchor.constraint(equalTo: songControllViews.topAnchor).isActive = true
        changeBackButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor).isActive = true
        
        songControllViews.addSubview(changeForwardButton)
        changeForwardButton.heightAnchor.constraint(equalTo: songControllViews.heightAnchor).isActive = true
        changeForwardButton.widthAnchor.constraint(equalTo: changeForwardButton.heightAnchor).isActive = true
        changeForwardButton.topAnchor.constraint(equalTo: songControllViews.topAnchor).isActive = true
        changeForwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor).isActive = true
        
        songControllViews.addSubview(shuffleButton)
        shuffleButton.heightAnchor.constraint(equalTo: songControllViews.heightAnchor).isActive = true
        shuffleButton.widthAnchor.constraint(equalTo: shuffleButton.heightAnchor).isActive = true
        shuffleButton.topAnchor.constraint(equalTo: songControllViews.topAnchor).isActive = true
        shuffleButton.trailingAnchor.constraint(equalTo: changeBackButton.leadingAnchor).isActive = true
        
        songControllViews.addSubview(repeatButton)
        repeatButton.heightAnchor.constraint(equalTo: songControllViews.heightAnchor).isActive = true
        repeatButton.widthAnchor.constraint(equalTo: repeatButton.heightAnchor).isActive = true
        repeatButton.topAnchor.constraint(equalTo: songControllViews.topAnchor).isActive = true
        repeatButton.leadingAnchor.constraint(equalTo: changeForwardButton.trailingAnchor).isActive = true

        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: changeBackButton.bottomAnchor, constant: 20).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
