//
//  audioVC.swift
//  Spotify
//
//  Created by Antonis Vozikis on 04/06/2017.
//  Copyright © 2017 Antonis Vozikis. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioVC: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var image = UIImage()
    var mainSongTitle = String()
    var mainPreviewURL = String()
    
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        
        background.image = image
        
        mainImageView.image = image
        
        downloadFileFromUrl(url: URL(string: mainPreviewURL)!)
        playPauseBtn.setTitle("Pause", for: .normal)
        
        
        
    }
    
    func downloadFileFromUrl(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customURL, response, error in
            
            self.play(url: customURL!)
            
        })
        downloadTask.resume()
    }
    
    @IBAction func pausePlayButton(_ sender: Any) {
        if player.isPlaying {
                player.pause()
            playPauseBtn.setTitle("Play", for: .normal)
        }
        else {
            player.play()
            playPauseBtn.setTitle("Pause", for: .normal)
        }
    }
    func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        }
        catch {
            print(error)
        }
    }
    
}
