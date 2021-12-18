//
//  ViewController.swift
//  holidayCalendar
//
//  Created by Vera on 2021/11/1.
//

import UIKit
import FSCalendar
import PKHUD

//MARK: - 基础设定
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    var everLaunched = false
    
    var selectedMonth : Int?
    var datesWithEvent = ["2022-01-01",
                          "2022-01-02",
                          "2022-01-03",
                          "2022-01-31",
                          "2022-02-01",
                          "2022-02-02",
                          "2022-02-03",
                          "2022-02-04",
                          "2022-02-05",
                          "2022-02-06",
                          "2022-04-03",
                          "2022-04-04",
                          "2022-04-05",
                          "2022-04-30",
                          "2022-05-01",
                          "2022-05-02",
                          "2022-05-03",
                          "2022-05-04",
                          "2022-06-03","2022-06-04","2022-06-05",
                          "2022-09-10","2022-09-11","2022-09-12",
                          "2022-10-01","2022-10-02","2022-10-03","2022-10-04","2022-10-05","2022-10-06","2022-10-07",]
  
    
    var workdays = ["2022-01-29",
                    "2022-01-30",
                    "2022-04-02",
                    "2022-04-24",
                    "2022-05-07",
                    "2022-10-08",
                    "2022-10-09",]
    
    var eventMonth = [1,2,4,5,6,9,10]
    
    var dark = false
   
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    @IBOutlet weak var monthList: monthCollection!
    
    @IBOutlet weak var calendarBG: UIView!
    
    @IBOutlet weak var bg: UIImageView!
    
    @objc func btn(sender: UIButton) {
        selectedMonth = sender.tag
        monthList.reloadData()
        //print(sender.tag+1)
    }
    
    //箭头,点击切换月份
//    @IBAction func buttonLeft(_ sender: UIButton) {
//        let currentDay = fsCalendar.currentPage
//        var components = DateComponents()
//        let calendar = Calendar(identifier: .gregorian)
//        components.month = -1
//        let nextDay = calendar.date(byAdding: components, to: currentDay)!
//        fsCalendar.setCurrentPage(nextDay, animated: true)
//    }
//
//    @IBOutlet weak var buttonLeft: UIButton!
//
//    @IBAction func buttonRight(_ sender: UIButton) {
//        let currentDay = fsCalendar.currentPage
//        var components = DateComponents()
//        let calendar = Calendar(identifier: .gregorian)
//        components.month = 1
//        let nextDay = calendar.date(byAdding: components, to: currentDay)!
//        fsCalendar.setCurrentPage(nextDay, animated: true)
//    }
//    @IBOutlet weak var buttonRight: UIButton!
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //时间转时间格式
    func timeToTimeStamp(time: String) -> Date {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        return dfmatter.date(from: time)!
    }
    
    //gradient color
//    override func viewDidLayoutSubviews() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.frame
//        gradientLayer.colors = [UIColor(named: "y" )!.cgColor, UIColor(named: "o")!.cgColor]
//        let gradientLocations:[NSNumber] = [0.0, 1.0]
//        gradientLayer.locations = gradientLocations
//
//
//        _updateColors(gradientLayer,at: 0)
//
//
//
//    }

    //包装渐变色
//    private func _updateColors(_ layer: CALayer, at idx: UInt32) {
//
//        view.layer.insertSublayer(layer,at:idx)
//    }
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//
//
//        self.loadViewIfNeeded()
//
//
//    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //titleName.textColor = UIColor(named: "titleColor")
        
        //view.backgroundColor =
//        buttonLeft.setImage(UIImage(named: "arrowLeftHighlight"), for: .highlighted)
//        buttonLeft.setImage(UIImage(named: "arrowLeft"), for: .normal)
//        buttonRight.setImage(UIImage(named: "arrowRightHighlight"), for: .highlighted)
//        buttonRight.setImage(UIImage(named: "arrowRight"), for: .normal)
        
       
        
        //月份列表
        monthList.delegate = self
        monthList.dataSource = self
        monthList.backgroundColor = .none
        
        
        //月日历
        fsCalendar.delegate = self
        fsCalendar.dataSource = self
        
        //注册cell
        fsCalendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        fsCalendar.translatesAutoresizingMaskIntoConstraints = false
        
        
        fsCalendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fsCalendar.placeholderType = .none
       
        fsCalendar.locale = Locale(identifier: "zh")
        
        fsCalendar.clipsToBounds = true
        fsCalendar.layer.cornerRadius = 24
        bg.clipsToBounds = true
        bg.layer.cornerRadius = 24
        
        //打开时,月份列表显示当月月份
        let month = Calendar.current.component(.month, from:  Date())
        selectedMonth = month - 1
        monthList.reloadData()
        
        fsCalendar.allowsMultipleSelection = false
        fsCalendar.swipeToChooseGesture.isEnabled = false // Swipe-To-Choose
        fsCalendar.scrollDirection = .horizontal
        
       // let scopeGesture = UIPanGestureRecognizer(target: fsCalendar, action: #selector(fsCalendar.handleScopeGesture(_:)));
        //fsCalendar.addGestureRecognizer(scopeGesture)
        print("didload")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "everLaunched") != true{
            self.performSegue(withIdentifier: "intro", sender: self)
            UserDefaults.standard.set(!everLaunched, forKey:"everLaunched")
        }
            
          
            print("第一次已完成")
      //  }
        
        
    }
    
    
    
    
    
}

//MARK: - 月份列表交互
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (monthList.frame.width-60)/6, height: 69)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    //月份的12个cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as! monthCell
        //cell.text.titleLabel?.text = "\(indexPath.item + 1)"
        cell.text.setTitle("\(indexPath.item + 1)", for: .normal)
        //圆角
        cell.layer.cornerRadius = 24
        cell.text.tag = indexPath.item
        cell.text.addTarget(self, action: #selector(btn(sender:)), for: .touchUpInside)
        cell.text.frame.size.width = cell.frame.width
        
        
            if indexPath.item+1 == 1 || indexPath.item+1 == 2 || indexPath.item+1 == 4 || indexPath.item+1 == 5 || indexPath.item+1 == 6 || indexPath.item+1 == 9 ||
                indexPath.item+1 == 10 {
                //print("i",indexPath.item+1)
                cell.round.layer.opacity = 1
            }else{
                cell.round.layer.opacity = 0
            }
        
        
        if indexPath.item == selectedMonth{
            //日历转为点击月的日历
            let selectedMonthString = "2022年\(indexPath.item + 1)月1日"
            let selectedDate = timeToTimeStamp(time: selectedMonthString)
            fsCalendar.setCurrentPage(selectedDate, animated: false)
            //点击变色
            cell.text.backgroundColor = .clear
            cell.text.tintColor = UIColor.label
            cell.backgroundColor = UIColor(named: "selectedMonth")
        }else{
            //未选中月份的文字及背景色
            cell.text.backgroundColor = .clear
            cell.text.tintColor = UIColor(named: "normalMonth")
            cell.backgroundColor = UIColor(named: "f0.5")
        }
        
        cell.round.clipsToBounds = true
        cell.round.layer.cornerRadius = 3
        
        
        return cell
    }

}

//MARK: - 日历交互
extension ViewController:FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance{

    //选择日期,根据选择的日期判断底色的形状
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            fsCalendar.visibleCells().forEach { (cell) in
                let cell = cell as! DIYCalendarCell
                cell.selectionType = .none
                cell.selectionLayer.isHidden = true
                
            }
            let cell = calendar.cell(for: date, at: monthPosition) as! DIYCalendarCell
            //print("选中日期",fsCalendar.selectedDates)
            //cell.selectionLayer.isHidden = false
            cell.selectionType = .single
            
            let key = self.dateFormatter2.string(from: date)
            
            // 元旦1/3
            if [self.datesWithEvent[0]].contains(key) {
                showNotice(string: "🐯元旦", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
            }
            
            // 元旦2/3
            if [self.datesWithEvent[1]].contains(key){
                showNotice(string: "🐯元旦", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            // 元旦3/3
            if [self.datesWithEvent[2]].contains(key){
                showNotice(string: "🐯元旦", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //春节 1/1
            if [self.datesWithEvent[3]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                
            }
            
            //春节 1/6
            if [self.datesWithEvent[4]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:5)
            }
            
            //春节 2/6
            if [self.datesWithEvent[5]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:-1)
            }
            
            //春节 3/6
            if [self.datesWithEvent[6]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            //春节 4/6
            if [self.datesWithEvent[7]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            //春节 5/6
            if [self.datesWithEvent[8]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            //春节 6/6
            if [self.datesWithEvent[9]].contains(key){
                showNotice(string: "🧧春节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-5)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            
            //清明节 1/3
            if [self.datesWithEvent[10]].contains(key){
                showNotice(string: "🏞️清明节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            // 清明2/3
            if [self.datesWithEvent[11]].contains(key){
                showNotice(string: "🏞️清明节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            // 清明3/3
            if [self.datesWithEvent[12]].contains(key){
                showNotice(string: "🏞️清明节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //劳动节 1/1
            if [self.datesWithEvent[13]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji")
            }
            
            //劳动节 1/4
            if [self.datesWithEvent[14]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
            }
            
            // 劳动节2/4
            if [self.datesWithEvent[15]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
            }
            
            // 劳动节3/4
            if [self.datesWithEvent[16]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:1)
            }
            
            // 劳动节4/4
            if [self.datesWithEvent[17]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-3)
            }
            
            //端午节 1/3
            if [self.datesWithEvent[18]].contains(key){
                showNotice(string: "🚣端午节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            //端午节2/3
            if [self.datesWithEvent[19]].contains(key){
                showNotice(string: "🚣端午节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            // 端午节3/3
            if [self.datesWithEvent[20]].contains(key){
                showNotice(string: "🚣端午节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //中秋节 1/3
            if [self.datesWithEvent[21]].contains(key){
                showNotice(string: "🥮中秋节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            //中秋节2/3
            if [self.datesWithEvent[22]].contains(key){
                showNotice(string: "🥮中秋节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            //中秋节3/3
            if [self.datesWithEvent[23]].contains(key){
                showNotice(string: "🥮中秋节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //国庆节 1/7
            if [self.datesWithEvent[24]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:5)
                aroundCellColorChange(value:6)
                
            }
            
            //春节 2/7
            if [self.datesWithEvent[25]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:5)
            }
            
            //春节 3/7
            if [self.datesWithEvent[26]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:4)
            }
            
            //春节 4/7
            if [self.datesWithEvent[27]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:3)
            }
            
            //春节 5/7
            if [self.datesWithEvent[28]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:2)
            }
            
            //春节 6/7
            if [self.datesWithEvent[29]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-5)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            //春节 7/7
            if [self.datesWithEvent[30]].contains(key){
                
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji")
                aroundCellColorChange(value:-5)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-6)
            }
            
            //搬砖
            if self.workdays.contains(key){
                showNotice(string: "😅调班", imageString: "Clapping Hands Emoji")
            }
            
            //相邻的日期变化
            func aroundCellColorChange(value:Int){
                let date = self.gregorian.date(byAdding: .day, value: value, to: date)!
                let cell = calendar.cell(for: date, at: monthPosition) as! DIYCalendarCell
                cell.selectionType = .single
                cell.selectionLayer.isHidden = false
                
                
            }
            
            //显示提示
            func showNotice(string:String,imageString:String){
                PKHUD.sharedHUD.contentView = NoticeView(string: string, imageString:imageString )
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.dimsBackground = false
                PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
                PKHUD.sharedHUD.hide(afterDelay: 1.0)
            }
            

 
           
        }
    
    //反选
        func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
            
            fsCalendar.visibleCells().forEach { (cell) in
                let diyCell = cell as! DIYCalendarCell
                
                    diyCell.selectionLayer.isHidden = true
                
            }
 
        }
    
    // FSCalendarDataSource
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let cell = fsCalendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)  as! DIYCalendarCell
        cell.imageView.contentMode = .scaleAspectFit
        
        
        //cell.selectionType = .none
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
       
    //被选中时 原来的底色去掉
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
//            
//        return UIColor.clear
//        
//        }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return UIColor.systemGray6
    }
    
    

    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        let key = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(key){
            return "😂"
        }else if self.workdays.contains(key){
            return "🧱"
        }
        return nil
    }
    
    //获取当前页面时间信息
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // Do something
        //calendar.deselect(calendar.currentPage)
        fsCalendar.visibleCells().forEach { (cell) in
            let diyCell = cell as! DIYCalendarCell
            
                diyCell.selectionLayer.isHidden = true
            
        }
        //print("当前页面时间:",calendar.currentPage)
        let month = Calendar.current.component(.month, from: calendar.currentPage)
        
        //获取滑动时当前月份值
        //print("month value",month)
        selectedMonth = month-1
        monthList.reloadData()
    }
    
    

    

    
}


//extension CAGradientLayer {
//
//    //获取彩虹渐变层
//    func rainbowLayer() -> CAGradientLayer {
//        //定义渐变的颜色（7种彩虹色）
//        let gradientColors = [UIColor.red.cgColor,
//                              UIColor.orange.cgColor,
//                              UIColor.yellow.cgColor,
//                              UIColor.green.cgColor,
//                              UIColor.cyan.cgColor,
//                              UIColor.blue.cgColor,
//                              UIColor.purple.cgColor]
//
//        //定义每种颜色所在的位置
//        let gradientLocations:[NSNumber] = [0.0, 0.17, 0.33, 0.5, 0.67, 0.83, 1.0]
//
//        //创建CAGradientLayer对象并设置参数
//        self.colors = gradientColors
//        self.locations = gradientLocations
//
//        //设置渲染的起始结束位置（横向渐变）
//        self.startPoint = CGPoint(x: 0, y: 0)
//        self.endPoint = CGPoint(x: 1, y: 0)
//
//        return self
//    }
//}

