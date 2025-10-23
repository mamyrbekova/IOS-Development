//
//  ViewController.swift
//  RandomizerApp_Amina
//
//  Created by Амина Мамырбекова on 20.10.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Favourite: UIImageView!
    @IBOutlet weak var Randomize: UIButton!
    
    
    let favouriteImages: [UIImage]  =  [#imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "sport"), #imageLiteral(resourceName: "book"), #imageLiteral(resourceName: "flowers"), #imageLiteral(resourceName: "song"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "season"), #imageLiteral(resourceName: "colour"), #imageLiteral(resourceName: "scent")]
//    let favouriteImagesEnum: [UIImage] = [
//        .car, .cat, .sport, .book, .flowers, .song, .dog, .season, .colour, .scent
//    ]
    
    let favouriteTitles: [String] = [
            "Favorite Car",
            "Favorite Cat Breed",
            "Favorite Sport",
            "Favorite Book",
            "Favorite Flower",
            "Favorite Song",
            "Favorite Dog",
            "Favorite Season",
            "Favorite Color",
            "Favorite Scent"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showRandomItem()
    }
    
    
    @IBAction func randomize(_ sender: Any) {
        showRandomItem()
    }
        
    private func showRandomItem() {
        let randomIndex = Int.random(in: 0..<favouriteImages.count)
        Favourite.image = favouriteImages[randomIndex]
        Name.text = favouriteTitles[randomIndex]
    }
    
    
}

