//
//  MathVC.swift
//  Assignment
//
//  Created by Cooldown on 21/8/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import UIKit
import AVFoundation

class MathVC: UIViewController {
    
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    @IBOutlet weak var back:UIButton!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var nextProblem: UIButton!
    
    var correctSong = AVAudioPlayer()
    var wrongSong = AVAudioPlayer()
    
    var num1 = Int()
    var num2 = Int()
    var signnum = Int()
    var sign = String()
    var score = Int(0)
    var answer = Int()
    var ansmixnum = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLbl.isHidden = false
        ans1.isHidden = false
        ans2.isHidden = false
        ans3.isHidden = false
        ans4.isHidden = false
        resultLbl.isHidden = true
        nextProblem.isHidden = true
        scoreLbl.text = "Score: \(score)"
        num1 = Int(arc4random_uniform(100))
        num2 = Int(arc4random_uniform(99))
        signnum = Int(arc4random_uniform(3))
        
        do {
            correctSong = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!))
            correctSong.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        do {
            wrongSong = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Wrong", ofType: "mp3")!))
            wrongSong.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        switch signnum {
        case 0:
            sign = "+"
            answer = num1 + num2
            questionLbl.text = "\(num1) \(sign) \(num2) = "
            ansmixnum = Int(arc4random_uniform(4))
            switch ansmixnum {
            case 0:
                ans1.setTitle("\(answer - 2)", for: .normal)
                ans2.setTitle("\(answer - 10)", for: .normal)
                ans3.setTitle("\(answer)", for: .normal)
                ans4.setTitle("\(answer + 10)", for: .normal)
                break
            case 1:
                ans1.setTitle("\(answer - 10)", for: .normal)
                ans2.setTitle("\(answer - 2)", for: .normal)
                ans3.setTitle("\(answer + 10)", for: .normal)
                ans4.setTitle("\(answer)", for: .normal)
                break
            case 2:
                ans1.setTitle("\(answer)", for: .normal)
                ans2.setTitle("\(answer + 2)", for: .normal)
                ans3.setTitle("\(answer + 10)", for: .normal)
                ans4.setTitle("\(answer - 10)", for: .normal)
                break
            case 3:
                ans1.setTitle("\(answer + 10)", for: .normal)
                ans2.setTitle("\(answer)", for: .normal)
                ans3.setTitle("\(answer + 2)", for: .normal)
                ans4.setTitle("\(answer - 10)", for: .normal)
            default:
                break
            }
            break
        case 1:
            sign = "-"
            answer = num1 - num2
            questionLbl.text = "\(num1) \(sign) \(num2) = "
            ansmixnum = Int(arc4random_uniform(4))
            switch ansmixnum {
            case 0:
                ans1.setTitle("\(answer - 2)", for: .normal)
                ans2.setTitle("\(answer - 1)", for: .normal)
                ans3.setTitle("\(answer)", for: .normal)
                ans4.setTitle("\(answer + 1)", for: .normal)
                break
            case 1:
                ans1.setTitle("\(answer - 1)", for: .normal)
                ans2.setTitle("\(answer - 2)", for: .normal)
                ans3.setTitle("\(answer + 1)", for: .normal)
                ans4.setTitle("\(answer)", for: .normal)
                break
            case 2:
                ans1.setTitle("\(answer)", for: .normal)
                ans2.setTitle("\(answer + 2)", for: .normal)
                ans3.setTitle("\(answer + 1)", for: .normal)
                ans4.setTitle("\(answer - 1)", for: .normal)
                break
            case 3:
                ans1.setTitle("\(answer + 1)", for: .normal)
                ans2.setTitle("\(answer)", for: .normal)
                ans3.setTitle("\(answer + 2)", for: .normal)
                ans4.setTitle("\(answer - 2)", for: .normal)
            default:
                break
            }
            break
        case 2:
            sign = "x"
            answer = num1 * num2
            questionLbl.text = "\(num1) \(sign) \(num2) = "
            ansmixnum = Int(arc4random_uniform(4))
            switch ansmixnum {
            case 0:
                ans1.setTitle("\(answer - 2)", for: .normal)
                ans2.setTitle("\(answer - 1)", for: .normal)
                ans3.setTitle("\(answer)", for: .normal)
                ans4.setTitle("\(answer + 1)", for: .normal)
                break
            case 1:
                ans1.setTitle("\(answer - 1)", for: .normal)
                ans2.setTitle("\(answer - 2)", for: .normal)
                ans3.setTitle("\(answer + 1)", for: .normal)
                ans4.setTitle("\(answer)", for: .normal)
                break
            case 2:
                ans1.setTitle("\(answer)", for: .normal)
                ans2.setTitle("\(answer + 2)", for: .normal)
                ans3.setTitle("\(answer + 1)", for: .normal)
                ans4.setTitle("\(answer - 1)", for: .normal)
                break
            case 3:
                ans1.setTitle("\(answer + 1)", for: .normal)
                ans2.setTitle("\(answer)", for: .normal)
                ans3.setTitle("\(answer + 2)", for: .normal)
                ans4.setTitle("\(answer - 2)", for: .normal)
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    @IBAction func answer1(_ sender: Any) {
        resultLbl.isHidden = false
        nextProblem.isHidden = false
        if ansmixnum == 0 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 1 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 2 {
            score = score + 1
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Correct !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.7524079623))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            correctSong.play()
        } else if ansmixnum == 3 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        }
    }
    
    @IBAction func answer2(_ sender: Any) {
        resultLbl.isHidden = false
        nextProblem.isHidden = false
        if ansmixnum == 0 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 1 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 3 {
            score = score + 1
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Correct !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.7524079623))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            correctSong.play()
        } else if ansmixnum == 2 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        }
    }
    
    @IBAction func answer3(_ sender: Any) {
        resultLbl.isHidden = false
        nextProblem.isHidden = false
        if ansmixnum == 3 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 1 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 0 {
            score = score + 1
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Correct !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.7524079623))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            correctSong.play()
        } else if ansmixnum == 2 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        }
    }
    
    @IBAction func answer4(_ sender: Any) {
        resultLbl.isHidden = false
        nextProblem.isHidden = false
        if ansmixnum == 0 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 3 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        } else if ansmixnum == 1 {
            score = score + 1
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Correct !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.7524079623))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            correctSong.play()
        } else if ansmixnum == 2 {
            if (score == 0) {
                score = 0
            } else {
                score = score - 1
            }
            scoreLbl.text = "Score: \(score)"
            resultLbl.text = "Wrong !!!"
            resultLbl.textColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            questionLbl.isHidden = true
            ans1.isHidden = true
            ans2.isHidden = true
            ans3.isHidden = true
            ans4.isHidden = true
            wrongSong.play()
        }
    }
    @IBAction func nextBtn(_ sender: Any) {
        viewDidLoad()
    }
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
