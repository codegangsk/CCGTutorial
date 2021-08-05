/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

enum CardType : Int {
    case fool,
         magician
}

class Card : SKSpriteNode {
    let cardType : CardType
    let frontTexture : SKTexture
    let backTexture : SKTexture
    var faceUp = true
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType : CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "smith_back")
        
        switch cardType {
        case .fool:
            frontTexture = SKTexture(imageNamed: "fool")
        case .magician:
            frontTexture = SKTexture(imageNamed: "magician")
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
    
    func flip() {
        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.4)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.4)
        
        setScale(1.0)
        
        if faceUp {
            run(firstHalfFlip) {
                self.texture = self.backTexture
                self.run(secondHalfFlip)
            }
        } else {
            run(firstHalfFlip) {
                self.texture = self.frontTexture
                self.run(secondHalfFlip)
            }
        }
        faceUp = !faceUp
    }
}

