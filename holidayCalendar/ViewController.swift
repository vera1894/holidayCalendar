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
    
    private let fireworkController = ClassicFireworkController()
    
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
    //1.29 1.30
    var twoDays = ["2022-01-29",
                   "2022-01-30"
    ]
    //剩下的
    var leftDays = ["2022-04-02",
                    "2022-04-24",
                    "2022-05-07",
                    "2022-10-08",
                    "2022-10-09"
    ]
    
    var eventMonth = [1,2,4,5,6,9,10]
    
    var dark = false
   
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    @IBOutlet weak var monthList: monthCollection!
    
    @IBOutlet weak var calendarBG: UIView!
    
    @IBOutlet weak var bg: UIImageView!
    
    @objc func btn(sender: UIButton) {
        selectedMonth = sender.tag
       // self.fireworkController.addFireworks(count: 2, sparks: 8, around: sender)
        monthList.reloadData()
        //print(sender.tag+1)
    }

    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var dateFormatter3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd,EEE"
        return formatter
    }()
    
    //时间转时间格式
    func timeToTimeStamp(time: String) -> Date {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        return dfmatter.date(from: time)!
    }
    
    //由后台进入前台时选择今天
//    @objc func applicationDidBecomeActive(notification: NSNotification) {
//            if(self.isViewLoaded && (self.view.window != nil)){
//                //fsCalendar.reloadData()
//                fsCalendar.select(fsCalendar.today)
//                //debugPrint("*进入前台--------由另一个程序回到当前程序应用*")
//            }
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //由后台进入前台时选择今天
        //NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        //月份列表
        monthList.delegate = self
        monthList.dataSource = self
        monthList.backgroundColor = .none
        //monthList.isAccessibilityElement = true
        //monthList.accessibilityLabel = "2022年1-12月月份列表"
        
        
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
        
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "everLaunched") != true{
            self.performSegue(withIdentifier: "intro", sender: self)
            UserDefaults.standard.set(!everLaunched, forKey:"everLaunched")
        }
        fsCalendar.reloadData()
            
          
         //   print("第一次已完成")
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
        cell.text.isAccessibilityElement = true
        cell.text.accessibilityLabel = "\(indexPath.item + 1)月"
        //cell.text.accessibilityViewIsModal = true
        //cell.isAccessibilityElement = true
        
        
        
            if indexPath.item+1 == 1 || indexPath.item+1 == 2 || indexPath.item+1 == 4 || indexPath.item+1 == 5 || indexPath.item+1 == 6 || indexPath.item+1 == 9 ||
                indexPath.item+1 == 10 {
                //print("i",indexPath.item+1)
                cell.round.layer.opacity = 1
                cell.text.accessibilityHint = "该月份有法定放假日"
            }else{
                cell.round.layer.opacity = 0
                cell.text.accessibilityHint = ""
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
          //  let cell = calendar.cell(for: date, at: monthPosition) as! DIYCalendarCell
//            //print("选中日期",fsCalendar.selectedDates)
//            //cell.selectionLayer.isHidden = false
//            cell.selectionType = .single
            
            
            //cell.titleLabel.accessibilityLabel = "000"
            let key = self.dateFormatter2.string(from: date)
            
            // 元旦1/3
            if [self.datesWithEvent[0]].contains(key) {
                showNotice(string: "🐯元旦", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            // 元旦2/3
            if [self.datesWithEvent[1]].contains(key){
                showNotice(string: "🐯元旦", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
                
            }
            
            // 元旦3/3
            if [self.datesWithEvent[2]].contains(key){
                showNotice(string: "🐯元旦", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
                
            }
            
            //春节 1/1
            if [self.datesWithEvent[3]].contains(key){
                showNotice(string: "🧧春节（腊月廿九）", imageString:"Clapping Hands Emoji",width: 200)
                
            }
            
            //春节 1/6
            if [self.datesWithEvent[4]].contains(key){
                showNotice(string: "🧧春节（正月初一）", imageString:"Clapping Hands Emoji",width: 200)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:5)
                
            }
            
            //春节 2/6
            if [self.datesWithEvent[5]].contains(key){
                showNotice(string: "🧧春节（正月初二）", imageString:"Clapping Hands Emoji",width: 200)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:-1)
            }
            
            //春节 3/6
            if [self.datesWithEvent[6]].contains(key){
                showNotice(string: "🧧春节（正月初三）", imageString:"Clapping Hands Emoji",width: 200)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            //春节 4/6
            if [self.datesWithEvent[7]].contains(key){
                showNotice(string: "🧧春节（正月初四）", imageString:"Clapping Hands Emoji",width: 200)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            //春节 5/6
            if [self.datesWithEvent[8]].contains(key){
                showNotice(string: "🧧春节（正月初五）", imageString:"Clapping Hands Emoji",width: 200)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            //春节 6/6
            if [self.datesWithEvent[9]].contains(key){
                showNotice(string: "🧧春节（正月初六）", imageString:"Clapping Hands Emoji",width: 200)
                aroundCellColorChange(value:-5)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
            }
            
            
            //清明节 1/3
            if [self.datesWithEvent[10]].contains(key){
                showNotice(string: "🏞️清明节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            // 清明2/3
            if [self.datesWithEvent[11]].contains(key){
                showNotice(string: "🏞️清明节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            // 清明3/3
            if [self.datesWithEvent[12]].contains(key){
                showNotice(string: "🏞️清明节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //劳动节 1/1
            if [self.datesWithEvent[13]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji",width: 100)
            }
            
            //劳动节 1/4
            if [self.datesWithEvent[14]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
            }
            
            // 劳动节2/4
            if [self.datesWithEvent[15]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
            }
            
            // 劳动节3/4
            if [self.datesWithEvent[16]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:1)
            }
            
            // 劳动节4/4
            if [self.datesWithEvent[17]].contains(key){
                showNotice(string: "🔆劳动节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-3)
            }
            
            //端午节 1/3
            if [self.datesWithEvent[18]].contains(key){
                showNotice(string: "🚣端午节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            //端午节2/3
            if [self.datesWithEvent[19]].contains(key){
                showNotice(string: "🚣端午节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            // 端午节3/3
            if [self.datesWithEvent[20]].contains(key){
                showNotice(string: "🚣端午节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //中秋节 1/3
            if [self.datesWithEvent[21]].contains(key){
                showNotice(string: "🥮中秋节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                
            }
            
            //中秋节2/3
            if [self.datesWithEvent[22]].contains(key){
                showNotice(string: "🥮中秋节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            //中秋节3/3
            if [self.datesWithEvent[23]].contains(key){
                showNotice(string: "🥮中秋节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-2)
            }
            
            //国庆节 1/7
            if [self.datesWithEvent[24]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:5)
                aroundCellColorChange(value:6)
                
            }
            
            //春节 2/7
            if [self.datesWithEvent[25]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:4)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:5)
            }
            
            //春节 3/7
            if [self.datesWithEvent[26]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:4)
            }
            
            //春节 4/7
            if [self.datesWithEvent[27]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:2)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:3)
            }
            
            //春节 5/7
            if [self.datesWithEvent[28]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:1)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:2)
            }
            
            //春节 6/7
            if [self.datesWithEvent[29]].contains(key){
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-5)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:1)
            }
            
            //春节 7/7
            if [self.datesWithEvent[30]].contains(key){
                
                showNotice(string: "🎇国庆节", imageString:"Clapping Hands Emoji",width: 100)
                aroundCellColorChange(value:-5)
                aroundCellColorChange(value:-4)
                aroundCellColorChange(value:-3)
                aroundCellColorChange(value:-2)
                aroundCellColorChange(value:-1)
                aroundCellColorChange(value:-6)
            }
            
            //搬砖
            if self.twoDays[0].contains(key){
                showNotice(string: "😅调班(腊月廿七)", imageString: "Clapping Hands Emoji",width: 200)
            }
            if self.twoDays[1].contains(key){
                showNotice(string: "😅调班(腊月廿八)", imageString: "Clapping Hands Emoji",width: 200)
            }
            if self.leftDays.contains(key){
                
                showNotice(string: "😅调班", imageString: "Clapping Hands Emoji",width: 100)
                
            }
            
            //相邻的日期变化
            func aroundCellColorChange(value:Int){
                let date = self.gregorian.date(byAdding: .day, value: value, to: date)!
                let cell = calendar.cell(for: date, at: monthPosition) as! DIYCalendarCell
                cell.selectionType = .single
                cell.selectionLayer.isHidden = false
                
                
            }
            
            //显示提示
            func showNotice(string:String,imageString:String,width:Double){
                PKHUD.sharedHUD.contentView = NoticeView(string: string, imageString:imageString,width: width )
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.dimsBackground = false
                PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
                PKHUD.sharedHUD.hide(afterDelay: 1.0)
                
            }
            
            func soundNotice(string1 label:String,string2 hint:String){
                let cell = calendar.cell(for: date, at: monthPosition) as! DIYCalendarCell
                cell.titleLabel.accessibilityLabel = label
                cell.titleLabel.accessibilityHint = hint
            }
            

 
           
        }
    
    //反选
        func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
            
            fsCalendar.visibleCells().forEach { (cell) in
                let diyCell = cell as! DIYCalendarCell
                
                    diyCell.selectionLayer.isHidden = true
                
            }
 
        }
    //MARK: - 日历数据
    // FSCalendarDataSource
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let cell = fsCalendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)  as! DIYCalendarCell
        cell.imageView.contentMode = .scaleAspectFit
        
        cell.titleLabel.accessibilityLabel = "\(self.dateFormatter3.string(from: date))"
        let key = self.dateFormatter2.string(from: date)
        if [self.datesWithEvent[0]].contains(key){
            cell.titleLabel.accessibilityHint = "元旦假期第1天，共3天"
        }
        if [self.datesWithEvent[1]].contains(key){
            cell.titleLabel.accessibilityHint = "元旦假期第2天，共3天"
        }
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
    
    //农历
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return LunarFormatter().string(from: date)
//    }

    

    
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

