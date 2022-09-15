//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 05.04.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // 1. Передать сюда массив с ответами
    // 2. Определить наиболее часто встречающийся тип животного
    // 3. Отобразить результат в соответсвии с этим животным
    // 4. Избавиться от кнопки возврата назад на экране результатов
    
    @IBOutlet var animalTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // 1. Передать сюда массив с ответами
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 4. Избавиться от кнопки возврата назад на экране результатов
        navigationItem.hidesBackButton = true
        updateResults()
    }
}

extension ResultsViewController {
    // 2. Определить наиболее часто встречающийся тип животного
    private func updateResults() {
        
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = answers.map { $0.type }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequencyAnimal)
    }
    // 3. Отобразить результат в соответсвии с этим животным
    private func updateUI(with animal: AnimalType?) {
        animalTypeLabel.text = "Вы - \(animal?.rawValue ?? " ")!"
        descriptionLabel.text = animal?.definition ?? ""
    }
}
