//
//  ViewController.swift
//  QuizGame
//
//  Created by Kshrugal Reddy Jangalapalli on 2/2/25.
//
/*
 Things we need:
 - Menu screen
 - Game screen
 - Answer object
 - Question Object
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame(){
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        
        present (vc,animated: true)
    }


}

