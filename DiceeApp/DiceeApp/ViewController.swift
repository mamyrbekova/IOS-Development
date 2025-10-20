//
//  ViewController.swift
//  DiceeApp
//
//  Created by Амина Мамырбекова on 20.10.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftDice: UIImageView!
    
    @IBOutlet weak var rightDice: UIImageView!
    
    @IBOutlet weak var rollButton: UIButton!
    
    let diceImages: [UIImage] = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")] //
    let diceImagesEnum: [UIImage] = [
        .diceOne, .diceTwo, .diceThree, .diceFour, .diceFive, .diceSix
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        leftDice.image = .diceThree
        rightDice.image = .diceFour
        rollButton.layer.cornerRadius = 16
        rollButton.backgroundColor = .systemTeal
    }


    @IBAction func rollButton(_ sender: Any) {
        let randomIndex = Int.random(in: 0..<diceImages.count)
        leftDice.image = diceImages[randomIndex] // getting random index
        rightDice.image = diceImages.randomElement()
    }
}

