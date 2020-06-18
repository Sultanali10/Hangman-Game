//
//  ViewController.swift
//  Hangman Game
//
//  Created by Sultan Ali on 18/06/2020.
//  Copyright © 2020 Sultan Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wordsArray = [String]()
    var word:String?
    var wordCharct = [Character]()
    var jointArrayForLabel = [String]()
    
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBAction func checkPressed(_ sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getWords()
        getWordFromArray()
        
    }
    
    func getWordFromArray(){
        wordsArray.shuffle()
        guard let word = wordsArray.first else {return}
        let upperWord = word.uppercased()
        
        for char in upperWord {
            wordCharct.append(char)
        }
        
        for _ in wordCharct{
            jointArrayForLabel.append("-")
        }
        
        let joined = jointArrayForLabel.joined()
        
        answerLabel.text = joined
        answerLabel.textColor = .red
        
        print(wordCharct)
        print(joined)
    }
    
    func getWords(){
        if let url = Bundle.main.url(forResource: "words", withExtension: "txt"){
            if let urlString = try? String(contentsOf: url){
                for word in urlString.split(separator: "\n") {
                    wordsArray.append(String(word))
                }
            }
        }
    }
}

