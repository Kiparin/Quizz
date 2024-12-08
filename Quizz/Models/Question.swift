//
//  Question.swift
//  Quizz
//
//  Created by Alexey Kiparin on 03.12.2024.
//

public struct Question{
    let title: String
    let type: QuestionType
    let answers: [Answer]
    
    static func getQuestion() -> [Question]{
        [
            Question(
                title: "Какуб пищу вы любите?",
                type: .singleChoice,
                answers: [
                    Answer(title: "Стейк", animal: .cat),
                    Answer(title: "Рыба", animal: .dog),
                    Answer(title: "Морковка", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle),
                ]
            ),
            Question(
                title: "Что вам нравится больше?",
                type: .multipleChoice,
                answers: [
                    Answer(title: "Плавать", animal: .cat),
                    Answer(title: "Спать", animal: .dog),
                    Answer(title: "Есть", animal: .rabbit),
                    Answer(title: "Обниматься", animal: .turtle),
                ]
            ),
            Question(
                title: "Любите ли вы поездки на автобусе?",
                type: .range,
                answers: [
                    Answer(title: "Не люблю", animal: .cat),
                    Answer(title: "Не очень люблю", animal: .dog),
                    Answer(title: "Люблю", animal: .rabbit),
                    Answer(title: "Очень люблю", animal: .turtle),
                ]
            ),
        ]
    }
}

enum QuestionType{
    case multipleChoice
    case singleChoice
    case range
}

struct Answer{
    let title: String
    let animal: Animal
}

enum Animal: Character{
    case cat = "🐱"
    case dog = "🐶"
    case rabbit = "🐰"
    case turtle = "🐢"
    case base = "🐌"
    
    var difinition: String{
        switch self {
        case .cat: return "A cat is a small, furry mammal that typically lives in households."
        case .dog: return "A dog is a type of domesticated mammal that typically lives in households."
        case .rabbit: return "A rabbit is a small, furry mammal that typically lives in households."
        case .turtle: return "A turtle is a slow-moving, cold-blooded reptile that typically lives in freshwater habitats."
        case .base: return "AHTUNG"
        }
    }
}
