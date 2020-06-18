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
     
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var checkButton: UIButton!
    @IBAction func checkPressed(_ sender: UIButton) {
        textField.resignFirstResponder()
        guard let unwrapedUserCharc = textField.text else {return}
        userCharc = Character(unwrapedUserCharc.uppercased())
        checkWordAvailable(my: userCharc!)
    }
    
    func checkWordAvailable(my newCharch: Character){
        for (position , charc) in word!.enumerated(){
            var i = 0
            if charc == userCharc {
//            print("positon of \(charc) is \(position)")
//                print(wordArray)
                wordArray[position] = charc
                newAnswer = String(wordArray)
//                print(newAnswer!)
            }
            i += 1
        }
        answerLabel.text = newAnswer
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 1
    }
    
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
    
    func getWordFromArray(){
        wordsArray.shuffle()
        guard let worde = wordsArray.first else {return}
        let upperWord = worde.uppercased()
        word = upperWord
        for char in upperWord {
            wordCharct.append(char)
        }
        
        for _ in wordCharct{
            jointArrayForLabel.append("-")
        }
        
         dashedWord = jointArrayForLabel.joined()
        
        answerLabel.text = dashedWord
        newAnswer = dashedWord
        wordArray = Array(dashedWord!)
        answerLabel.textColor = .red
        answerLabel.layer.borderWidth = 1
        answerLabel.layer.borderColor = UIColor.purple.cgColor
        
        print(wordCharct)
        print(dashedWord!)
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

