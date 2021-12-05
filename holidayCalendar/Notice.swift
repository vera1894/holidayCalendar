//
//  Notice.swift
//  holidayCalendar
//
//  Created by Vera on 2021/12/5.
//

import UIKit

import PKHUD

class PKHUDHelpDeskView: PKHUDWideBaseView {

    let button: UIButton = .init(type: .system)
    let label: UILabel = UILabel()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        button.setTitle("Call", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(self.helpDeskNumberButton(_:)), for: UIControl.Event.touchUpInside)

        label.text = "Call me now"
        label.textColor = UIColor.brown
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center

        self.addSubview(label)
        self.addSubview(button)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.button.frame = CGRect(x: 0, y: 0, width: self.frame.size.width/2, height: 30.0)
        self.label.frame = CGRect(x: 0, y: 30.0, width: self.frame.size.width, height: 40.0)
    }

    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel:\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }

    @objc  func helpDeskNumberButton(_ sender: Any) {
        callNumber(phoneNumber: "8005551234")
    }
}
