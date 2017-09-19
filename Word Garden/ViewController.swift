//
//  ViewController.swift
//  Word Garden
//
//  Created by oliver naser on 9/15/17.
//  Copyright © 2017 oliver naser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func  updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWorld = ""
        lettersGuessed += guessedLetterField.text!
        print(lettersGuessed)
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWorld = revealedWorld + " \(letter)"
                lettersGuessed += guessedLetterField.text!
            } else {
                revealedWorld += " _"
            }
        }
        revealedWorld.removeFirst()
        userGuessLabel.text = revealedWorld
    }
    
    func guessALetter() {
        guessCount += 1
       formatUserGuessLabel()
        //decrements wrong guesses and shows the next flower image with one less pedal
        let currentLetterGuessed =  guessedLetterField.text!
        if !wordToGuess.contains(guessedLetterField.text!){
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        

        let revealedWord = userGuessLabel.text!
        //stop game if wrong guesses remaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Sorry you are all out of guesses! Try again?"
        } else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Congrats, it took you \(guessCount) to guess the word!"
        } else {
            let guess = (guessCount == 1 ? "Guess" : "Guesses")
            //update our guess count
//            var guess = "guesses"
//            if guessCount == 1 {
//                guess = "Guess"
//            }
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: Any) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable the button if there isnt a single character in the guestLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: Any) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named:"flower8")
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 Guesses"
        guessCount = 0
        wrongGuessesRemaining = 8
    }
    
    
}
