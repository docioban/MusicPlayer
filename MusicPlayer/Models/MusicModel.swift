//
//  MusicModel.swift
//  MusicPlayer
//
//  Created by Macbook Pro on 21.01.2021.
//

import Foundation

struct Music: Codable {
    var name: String
    var author: String
    var fileName: String
    var imageName: String?
}
//
//var MUSICS: [MusicModel] = [
//    MusicModel(name: "Belaia roza", author: "Pugaciova", fileName: "musicDefault"),
//    MusicModel(name: "iunasti", author: "pasa", fileName: "musicDefault"),
//    MusicModel(name: "s cistava lista", author: "timati", fileName: "musicDefault")
//]
