//
//  Quizz
//
//  Created by Alexey Kiparin on 03.12.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet weak var emojiLable: UILabel!
    @IBOutlet weak var resultLable: UILabel!
    
    var questionsChoosen: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let result  = Dictionary(grouping: questionsChoosen) { $0.animal }
            .max { $0.value.count < $1.value.count }?.key ?? nil
        if result != nil {
            emojiLable.text = "Вы - \(result?.rawValue ?? Animal.base.rawValue)"
            resultLable.text = result?.difinition ?? Animal.base.difinition
        }
    }
    
    
    @IBAction func doneButtonClick(_ sender: Any) {
        dismiss(animated: true)
    }
}

