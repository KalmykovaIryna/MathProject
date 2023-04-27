//
//  MultiplicationVC.swift
//  MathProject
//
//  Created by Iryna Rarova on 29.08.2022.
//

import UIKit

class MultiplicationVC: UIViewController {
    
    @IBOutlet weak var multiplyView: UIView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var x1: UILabel!
    @IBOutlet weak var x2: UILabel!
    @IBOutlet weak var x3: UILabel!
    @IBOutlet weak var x4: UILabel!
    @IBOutlet weak var x5: UILabel!
    @IBOutlet weak var x6: UILabel!
    @IBOutlet weak var x7: UILabel!
    @IBOutlet weak var x8: UILabel!
    @IBOutlet weak var x9: UILabel!
    var result: Int = 1
    
    
    
    
   
    
    enum number {
      
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        
        var numberInt: Int? {
            switch self {
          
            case .one: return 1
            case .two: return 2
            case .three: return 3
            case .four: return 4
            case .five: return 5
            case .six: return 6
            case .seven: return 7
            case .eight: return 8
            case .nine: return 9
            }
        }
        
        var image: UIImage? {
            switch self {
           
            case .one: return UIImage(named: "1")
            case .two: return UIImage(named: "2")
            case .three: return UIImage(named: "3")
            case .four: return UIImage(named: "4")
            case .five: return UIImage(named: "5")
            case .six: return UIImage(named: "6")
            case .seven: return UIImage(named: "7")
            case .eight: return UIImage(named: "8")
            case .nine: return UIImage(named: "9")
            }
        }
        
        
    }
    
   
                    
    var multiplyImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        multiplyView.layer.borderWidth = 10
        multiplyView.layer.borderColor = UIColor.brown.cgColor
        multiplyView.layer.cornerRadius = 10
        createMultiplyTable(number: 1)
       

    }
    func createMultiplyTable(number: Int){
        headerLabel.text = "Таблиця множення на \(number)"
        x1.text = "\(number) x 1 = \(number * 1)"
        x2.text = "\(number) x 2 = \(number * 2)"
        x3.text = "\(number) x 3 = \(number * 3)"
        x4.text = "\(number) x 4 = \(number * 4)"
        x5.text = "\(number) x 5 = \(number * 5)"
        x6.text = "\(number) x 6 = \(number * 6)"
        x7.text = "\(number) x 7 = \(number * 7)"
        x8.text = "\(number) x 8 = \(number * 8)"
        x9.text = "\(number) x 9 = \(number * 9)"
        
    }
    
 

    @IBAction func goToBackButton() {
        navigationController?.popViewController(animated: true)
    }
//    @IBAction func goToTraining() {
//        if let multiplyTrainingVC = storyboard!.instantiateViewController(withIdentifier: "MultiplyTrainingVC") as? MultiplyTrainingViewController{
//        multiplyTrainingVC.number = result
//            present(multiplyTrainingVC, animated: true, completion: nil)}
//        
//       
//    }
    
    @IBAction func multiply1(){
        createMultiplyTable(number: 1)
        result = 1
    }
    @IBAction func multiply2(){
        createMultiplyTable(number: 2)
        result = 2
    }
    @IBAction func multiply3(){
        createMultiplyTable(number: 3)
        result = 3
    }
    @IBAction func multiply4(){
        createMultiplyTable(number: 4)
        result = 4
    }
    @IBAction func multiply5(){
        createMultiplyTable(number: 5)
        result = 5
    }
    @IBAction func multiply6(){
        createMultiplyTable(number: 6)
        result = 6
    }
    @IBAction func multiply7(){
        createMultiplyTable(number: 7)
        result = 7
    }
    @IBAction func multiply8(){
        createMultiplyTable(number: 8)
        result = 8
    }
    @IBAction func multiply9(){
        createMultiplyTable(number: 9)
        result = 9
    }
    @IBAction func multiply10(){
        createMultiplyTable(number: 10)
        result = 10
    }
    

}
