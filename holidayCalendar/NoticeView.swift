//
//  NoticeView.swift
//  holidayCalendar
//
//  Created by Vera on 2021/12/5.
//

import UIKit
import PKHUD

class NoticeView: PKHUDWideBaseView {

    let label = UILabel()
    var string = ""
    var imageString = ""
    
    init(string:String,imageString:String){
        super.init()
        self.string = string
        self.imageString = imageString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
//        label.text = "hhh"
//        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = .white
        let voiceAttr = NSMutableAttributedString()
                let imageAttachment = NSTextAttachment()
                let voiceImage = UIImage(named: "imageString")
                imageAttachment.image = voiceImage
                imageAttachment.bounds = CGRect(x: -2, y: -2, width: 18, height: 18)
                let imgAttr = NSAttributedString(attachment: imageAttachment)
                //voiceAttr.append(imgAttr)   //!!!有图片时把图片添加上
                let textArt = NSAttributedString(string: string)
                voiceAttr .append(textArt)
                label.attributedText = voiceAttr
        
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        label.textAlignment = NSTextAlignment.center
    }

}
