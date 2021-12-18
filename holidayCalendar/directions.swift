//
//  directions.swift
//  holidayCalendar
//
//  Created by Vera on 2021/12/10.
//

import UIKit

class directions: UIViewController {

    @IBOutlet weak var directionTitle: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.setTitle("继续", for: .normal)
    }
    
    @IBAction func dissmissFC(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
