//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denis Bystruev on 16/11/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var listOfWords = [
        "Арбуз",
        "Банан",
        "Гномик",
        "Домик",
        "Ель",
        "Ёж",
        "Дорога",
        ]
    
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            
        let newWord = listOfWords.removeFirst()
        game = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: []
        )
        
        enableletterButtons(true)
        
        } else {
             enableletterButtons(false)
        }
        updateUI()
    }
    
    
    func enableletterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        let imageName = "Tree \(game.incorrectMovesRemaining)"
        treeImageView.image = UIImage(named: imageName)
        
        var letters = [String]()
        let formattedWord = game.formattedWord.uppercased()
        for letter in formattedWord {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined (separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Выигрыши: \(totalWins),  Проигрыши: \(totalLosses)"
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character (letterString.lowercased())
        game.playerGuessed(letter: letter)
        updateGameState()

    }
    func updateGameState () {
        if game.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if game.word.lowercased() == game.formattedWord {
            totalWins += 1
        } else {
        updateUI()
        }
    }
    
}

