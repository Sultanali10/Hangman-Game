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

    override func viewDidLoad() {
        super.viewDidLoad()
        getWords()
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

