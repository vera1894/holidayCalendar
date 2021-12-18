//
//  cell.swift
//  holidayCalendar
//
//  Created by Vera on 2021/11/2.
//

import Foundation
import UIKit
import FSCalendar

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class DIYCalendarCell: FSCalendarCell {
    
    //weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
   // var circleLayer: UIView
    
    var selectionType: SelectionType = .none {
        didSet {
            
            setNeedsLayout()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.selectionType = .none
//            }
//            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor(named: "layout")?.cgColor
        selectionLayer.actions = ["hidden": NSNull()] 
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel!.layer)
        self.selectionLayer = selectionLayer
        
        
    }
    
    private func _updateColors(layer:CAShapeLayer,string:String) {
        layer.fillColor = UIColor(named: string)?.cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            self._updateColors(layer: selectionLayer, string: "layout")
            self.setNeedsDisplay()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.circleImageView.frame = self.contentView.bounds
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.selectionLayer.frame = self.contentView.bounds


        if selectionType == .middle {
           
            self.selectionLayer.path = UIBezierPath(rect: self.selectionLayer.bounds).cgPath
        }
        else if selectionType == .leftBorder {
            self.selectionLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
        }
        else if selectionType == .rightBorder {
            self.selectionLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
        }
        else if selectionType == .single {
            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
            self.selectionLayer.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2 + 3, y: self.contentView.frame.height / 2 - diameter / 2 , width: diameter-6, height: diameter-6)).cgPath 
        }
    }
    
}
