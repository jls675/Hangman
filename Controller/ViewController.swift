//
//  ViewController.swift
//  Hangman
//
//  Created by Jorge Sanchez on 1/13/19.
//  Copyright © 2019 Jorge Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let alphabet = [
        "A", "B", "C", "D", "E", "F",
        "G", "H", "I", "J", "K", "L",
        "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X",
        "Y", "Z"
    ]
    
    var gameStatus = [
        false, false, false, false, false, false,
        false, false, false, false, false, false,
        false, false, false, false, false, false,
        false, false, false, false, false, false,
        false, false
    ]
    
    let allWords = WordBank()
    var win: Bool = false
    var good = [String]()
    var bad = [String]()
    var chosenWord: String = ""
    
    @IBOutlet weak var secretWord: UILabel!
    @IBOutlet weak var feedBack: UILabel!
    @IBOutlet weak var counter: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        chosenWord = allWords.list[Int.random(in: 0...2)]
        displayWord()
        
    }

    @IBAction func LetterPressed(_ sender: UIButton) {
        
        let index = sender.tag - 1
        if bad.count < 6 && win == false {
            if gameStatus[index] == false {
                gameStatus[index] = true
                check(i: index)
                updateUI()
                victory()
            }
            else {
                feedBack.text = "You already guessed that Letter"
            }
        }
        
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        
        gameStatus = [
            false, false, false, false, false, false,
            false, false, false, false, false, false,
            false, false, false, false, false, false,
            false, false, false, false, false, false,
            false, false
        ]
        
        win = false
        good = [String]()
        bad = [String]()
        chosenWord = allWords.list[Int.random(in: 0...2)]
        
        feedBack.text = "Guess a Letter"
        counter.text = "Bad : 0/6"
        updateUI()
        
        
    }
    
    func check(i: Int){
        let guess = alphabet[i]
        if chosenWord.contains(guess) {
            good.append(guess)
            feedBack.text = "Correct! \(guess) is part of the word"
        }
        else {
            bad.append(guess)
            feedBack.text = "Incorrect"
            if bad.count == 6 {
                feedBack.text = "You Lost"
            }
            
        }
    }
    
    func updateUI(){
        displayWord()
        counter.text = "Bad : \(bad.count)/6"
    }
    
    func displayWord() {
        var str: String = ""
        for letter in chosenWord {
            if good.contains(String(letter)) {
                str += String(letter)
            }
            else {
                str += "_"
            }
        }
        secretWord.text = str
    }
    
    func victory() {
        
        var tempArray = [String]()
        for j in chosenWord where tempArray.contains(String(j)) == false {
            tempArray.append(String(j))
        }
        if tempArray.count == good.count {
            win = true
            feedBack.text = "You Won"
        }
        
    }
    
}

