import UIKit

class ViewController: UIViewController {
    
    lazy var game: ConcentrationGame = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count / 2))
    
    var flipCount = 0
    
    var emojiArray = ["⭐️", "🌕", "🌑", "☁️",
                      "☄️", "✨", "🌈", "❄️"]
    
    var emoji = [Int: String]()
    
    var currentRecord: Int?
    
    @IBOutlet weak var winnerTextLabel: UITextView!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var currentRecordLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        winnerTextLabel.text = ""
        if currentRecord != nil {
            currentRecord = min(currentRecord!, flipCount)
            currentRecordLabel.text = "Current record: \(currentRecord!)"
        } else if game.matchedCardsCount == cardButtons.count {
            currentRecordLabel.text = "Current record: \(flipCount)"
        }
        flipCount = 0
        flipCountLabel.text = "Flip count: 0"
        game.matchedCardsCount = 0
        game.indexOfOneAndOnlyFaceUpCard = nil
        for button in cardButtons {
            button.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            button.setTitle("", for: UIControl.State.normal)
        }
        for index in game.cards.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        game.cards.shuffle()
        emoji.removeAll()
        emojiArray = ["⭐️", "🌕", "🌑", "☁️",
                      "☄️", "✨", "🌈", "❄️"]
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        flipCount += 1
        flipCountLabel.text = "Flip count: \(flipCount)"
        
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }
    }
    
    func emoji(for card: Card) -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
        
        if emoji[card.identifier] == nil, !emojiArray.isEmpty {
            emoji[card.identifier] = emojiArray.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            }
        }
        if game.isEnded() {
            winnerTextLabel.text = "Congratulations, you won! Maybe another round?"
            winnerTextLabel.isEditable = false
        }
    }
}

