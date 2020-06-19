//
//  ViewController.swift
//  Hangman Game
//
//  Created by Sultan Ali on 18/06/2020.
//  Copyright © 2020 Sultan Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
    var wordsArray = [String]()
    var word:String?
    var wordCharct = [Character]()
    var jointArrayForLabel = [String]()
    var userCharc: Character?
    var dashedWord:String?
    var newAnswer:String?
    var wordArray = [Character]()
    var attempts = 7
    
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var checkButton: UIButton!
    
    @IBAction func checkPressed(_ sender: UIButton) {
        if textField.text != "" {
            guard let unwrapedUserCharc = textField.text else {return}
            userCharc = Character(unwrapedUserCharc.uppercased())
            checkWordAvailable(my: userCharc!)
            textField.text = ""
        } else {
            let ac = UIAlertController(title: "No Characters", message: "Please enter a character first", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    func checkWordAvailable(my newCharch: Character){
        for (position , charc) in word!.enumerated(){
            if charc == userCharc {
                wordArray[position] = charc
                newAnswer = String(wordArray)
            }
        }
        if newAnswer == answerLabel.text {
            attempts -= 1
            if attempts >= 1 {
                let ac = UIAlertController(title: "Oops", message: "This character is not part of the word, try another one. You have \(attempts) left", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Game Over", message: "You failed to discover the word, It was \(word!). Lets try another word :)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.getWordFromArray()
                })
                present(ac, animated: true)
            }
        } else if newAnswer == word {
            let ac = UIAlertController(title: "Congratulations", message: "You have discovered the word successfully. Lets have fun with another word", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
        } else {
            answerLabel.text = newAnswer
        }
        
    }
    // this code used to accept only one character in textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 1
    }
    
    // to hide keyboard when tap in any empty space on the page
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWords()
        getWordFromArray()
        hideKeyboardWhenTappedAround()
        checkButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkPressed)))
    }
    
    
    // get a word from the array of words then create dashes from it then show dashes on the app
    func getWordFromArray(){
        wordsArray.shuffle()
        guard let worde = wordsArray.first else {return}
        let upperWord = worde.uppercased()
        word = upperWord
        print(word!)
        wordCharct.removeAll()
        for char in upperWord {
            wordCharct.append(char)
        }
        
        jointArrayForLabel.removeAll()
        for _ in wordCharct{
            jointArrayForLabel.append("-")
        }
        dashedWord = ""
        dashedWord = jointArrayForLabel.joined()
        answerLabel.text = dashedWord
        newAnswer = dashedWord
        wordArray = Array(dashedWord!)
        answerLabel.textColor = .red
        answerLabel.layer.borderWidth = 1
        answerLabel.layer.borderColor = UIColor.purple.cgColor
    }
    
    // get words array from the file
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

