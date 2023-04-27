//
//  LabelsForView.swift
//  MathProject
//
//  Created by Iryna Rarova on 14.04.2023.
//

import Foundation
import UIKit

class ViewAndAdditions {
    
    func createView(tag: Int, xPosition: CGFloat, yPosition: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
        let view = UIView()
        view.tag = tag
        view.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(red: 218.0/255.0, green: 215.0/255.0, blue: 198.0 / 255.0, alpha: 1)
        view.layer.cornerRadius = 10
        let image = UIImage(named: "backgroundForViews")
        if let image = image {
            view.backgroundColor = UIColor(patternImage: image)
        }
        return view
    }
    
    func deleteView(view: UIView){
        UIView.animate(withDuration: 0.0, animations: {
            view.alpha = 0.0
        })
    }
 
    func countViewsWidth(mainViewWidth: CGFloat) -> CGFloat{
        let leftSafeArea: CGFloat = 16.0
        let rightSafeArea: CGFloat = 16.0
        let viewsWidth = (mainViewWidth - leftSafeArea - rightSafeArea - 20) / 5
        return viewsWidth
    }
    
    func countViewsHeight(mainViewHeight: CGFloat, topSafeArea: CGFloat?, bottomSafeArea: CGFloat?,  backButtonHeight: CGFloat) -> CGFloat{
        guard let topSafeArea = topSafeArea, let bottomSafeArea = bottomSafeArea else {return 0}
        let viewHeight = (mainViewHeight - topSafeArea - 16 - backButtonHeight - bottomSafeArea - 45 ) / 10
        return viewHeight
    }
    
    func createLabel(view: UIView, text: String, centerY: CGFloat = 0.0) -> UILabel {
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = text
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return label
    }
        
    func createLabelsForView(view: UIView, text: String, centerY: CGFloat = 0.0){
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = text
        label.font = UIFont.init(name: "AvenirNext-Bold", size: 18)
        label.textColor = UIColor(red: 37.0/255.0, green: 61.0/255.0, blue: 76.0 / 255.0, alpha: 1)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func deletelabel(id: String, arrayOfLabels: [stackViewLabels]){
        for label in arrayOfLabels {
            if label.id == id {
                label.alpha = 0.0
            }
        }
    }
}
