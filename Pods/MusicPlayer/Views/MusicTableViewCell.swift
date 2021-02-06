//
//  MusicTableViewCell.swift
//  MusicPlayer
//
//  Created by Macbook Pro on 21.01.2021.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .red
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let distanceBeetwenCells = CGFloat(5)
        
        contentView.addSubview(container)
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: distanceBeetwenCells).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: distanceBeetwenCells).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -distanceBeetwenCells).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -distanceBeetwenCells).isActive = true
            
        container.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        
        container.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
