//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Kshrugal Reddy Jangalapalli on 1/26/25.
//

import UIKit

enum Mode {
    case flashCard,quiz
}

enum State {
    case question, answer, score
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let fixedElementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var elementList: [String] = []
    var currentElementIndex = 0
    
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard:
                setupFlashCards()
            case .quiz:
                setupQuiz()
            }
            updateUI()
        }
    }
    
    var state: State = .question
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mode = .flashCard
    }
    
    func setupFlashCards() {
        state = .question
        currentElementIndex = 0
        elementList = fixedElementList
    }
    
    func setupQuiz() {
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
        elementList = fixedElementList.shuffled()
    }
    
    func updateUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    func updateFlashCardUI(elementName: String) {
        modeSelector.selectedSegmentIndex = 0
        textField.isHidden = true
        textField.resignFirstResponder()
        
        answerLabel.text = (state == .answer) ? elementName : "?"
        showAnswer.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("Next Element", for: .normal)
    }
    
    func updateQuizUI(elementName: String) {
        modeSelector.selectedSegmentIndex = 1
        textField.isHidden = (state == .score)
        
        switch state {
        case .question:
            textField.isEnabled = true
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.isEnabled = false
            textField.resignFirstResponder()
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
        }
        
        answerLabel.text = {
            switch state {
            case .question: return ""
            case .answer: return answerIsCorrect ? "Correct!" : "❌\nCorrect Answer: " + elementName
            case .score: return ""
            }
        }()
        
        if state == .score {
            displayScoreAlert()
        }
        
        showAnswer.isHidden = true
        nextButton.setTitle((currentElementIndex == elementList.count - 1) ? "Show Score" : "Next Question", for: .normal)
        nextButton.isEnabled = (state != .question)
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
        }
        state = .question
        updateUI()
    }
    
    @IBAction func switchModes(_ sender: Any) {
        mode = (modeSelector.selectedSegmentIndex == 0) ? .flashCard : .quiz
    }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text!
        
        answerIsCorrect = textFieldContents.lowercased() == elementList[currentElementIndex].lowercased()
        correctAnswerCount += answerIsCorrect ? 1 : 0
        
        state = .answer
        updateUI()
        
        return true
    }
    
    // MARK: - Alert Functions
    func displayScoreAlert() {
        let alert = UIAlertController(
            title: "Quiz Score",
            message: "Your score is \(correctAnswerCount) out of \(elementList.count).",
            preferredStyle: .alert
        )
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
}
