//
//  DownloadMusicViewController.swift
//  MusicPlayer
//
//  Created by Macbook Pro on 25.01.2021.
//

import UIKit
import SwiftyDropbox

class DownloadMusicViewController: UIViewController {

    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "gdfgsdgs"
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 20
//        button.titleLabel?.text = "Search"
//        button.titleLabel?.textColor = .darkGray
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let dropboxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dropboxButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitle("dropbox", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(downloadButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Download")
        setConstraints()
    }
    
    func setConstraints() {
        view.addSubview(searchTextField)
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(searchButton)
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dropboxButton)
        dropboxButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dropboxButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dropboxButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20).isActive = true
        dropboxButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(downloadButton)
        downloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        downloadButton.topAnchor.constraint(equalTo: dropboxButton.bottomAnchor, constant: 20).isActive = true
        downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @objc func searchButtonTap() {
        
    }
    
    @objc func dropboxButtonTap() {
        let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read"], includeGrantedScopes: false)
          DropboxClientsManager.authorizeFromControllerV2(
              UIApplication.shared,
              controller: self,
              loadingStatusDelegate: nil,
              openURL: { (url: URL) -> Void in UIApplication.shared.openURL(url) },
              scopeRequest: scopeRequest
          )
    }
    
    @objc func downloadButtonTap() {
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destURL = directoryURL.appendingPathComponent("/music.mp3")
        let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
            return destURL
        }
        
        let client = DropboxClientsManager.authorizedClient
        
        client?.files.downloadZip(path: "/music.mp3", overwrite: true, destination: destination)
            .response() { response, error in
                if let response = response {
                    print(response)
                } else if let error = error {
                    print(error)
                }
            }
            .progress { progressData in
                print(progressData)
            }
    }

    func loadFileAsync() {
        let str = "Super long string here"
        let filename = getDocumentsDirectory().appendingPathComponent("output.mp3")

        do {
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
