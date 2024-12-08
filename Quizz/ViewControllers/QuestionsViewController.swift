//
//  Quizz
//
//  Created by Alexey Kiparin on 03.12.2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabel: [UILabel]!
    @IBOutlet var multipleSwitch: [UISwitch]!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet var rangeLabel: [UILabel]!
    @IBOutlet weak var rangeSlider: UISlider!
    
    
    @IBOutlet weak var progressQuestionView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    //MARK: - Pivate Properties
    private var questionsChoosen: [Answer] = []
    private var currentQuestionIndex = 0
    private let questions = Question.getQuestion()
    private var answers: [Answer] {
        questions[currentQuestionIndex].answers
    }
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateUI()
        
        let answerCount = Float(answers.count - 1)
        rangeSlider.maximumValue = answerCount
        rangeSlider.value = answerCount / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultViewController {
            resultVC.questionsChoosen = questionsChoosen
        }
    }

    //MARK: - IB Actions
    @IBAction func singleQuestionButtonClick(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = answers[buttonIndex]
        questionsChoosen.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleQuestionButtonClick(_ sender: Any) {
        for (multipleSwich , answer ) in zip(multipleSwitch , answers) {
            if multipleSwich.isOn {
                questionsChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangeQuestionButtonClick(_ sender: Any) {
        let index = lrintf(rangeSlider.value)
        questionsChoosen.append(answers[index])
        nextQuestion()
    }
}

//MARK: Private Methods
private extension QuestionsViewController {
    func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangeStackView] {
            stackView?.isHidden = true
        }
        
        title = "Вопрос №\(currentQuestionIndex + 1) из \(questions.count)"
        
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.title
        let progress = Float(currentQuestionIndex) / Float(questions.count)
        progressQuestionView.setProgress(progress, animated: true)
        
        showCurrentAnswers(question.type)
    }
    
    func showCurrentAnswers(_ type: QuestionType) {
        switch type {
        case .singleChoice: showSingleAnswer(answers)
        case .multipleChoice: showMultipleAnswers(answers)
        case .range: showRangeAnswer(answers)
        }
    }
    
    func showSingleAnswer(_ answers: [Answer]) {
        singleStackView?.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleAnswers(_ answers: [Answer]) {
        multipleStackView?.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabel, answers) {
            label.text = answer.title
        }
    }
    
    func showRangeAnswer(_ answers: [Answer]) {
        rangeStackView?.isHidden.toggle()
        
        rangeLabel.first?.text = answers.first?.title
        rangeLabel.last?.text = answers.last?.title
        
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex >= questions.count {
            performSegue(withIdentifier: "showResult", sender: nil)
        } else {
            updateUI()
        }
    }
}
