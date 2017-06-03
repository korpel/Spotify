//
//  audioVC.swift
//  Spotify
//
//  Created by Antonis Vozikis on 04/06/2017.
//  Copyright © 2017 Antonis Vozikis. All rights reserved.
//

import Foundation
import UIKit

class AudioVC: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    var image = UIImage()
    var mainSongTitle = String()
    
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
        
    }
    
}
