import UIKit

var selectedDate = Date()

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
        
      
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    var totalSquares = [Date]()

    let defaults = UserDefaults.standard

    var plusMoney = 0
    var minusMoney = 0
    var accMoney = 0
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()

        // 초기화 함수도 이때 호출한다
        setCellsView() // 크기지정
        setWeekView() // 갯수지정
        
        plusMoney = 0
        minusMoney = 0
        
    
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        accMoney = plusMoney + accMoney - minusMoney
        
//        if( totalSquares.count == 0 ) {
//            showEditing.
//            showEditing.hidden = false
//        }
                
    }
        
    
    func setCellsView(){

        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as UICollectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    
    }
    
    
    
    // 컬렉션뷰를 매핑해줬음
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //함수에 아무내용 없이 바로 리턴해줄때는 return 생략해도됨
        //이거 출력해보면 42 가 나오는데, 월~일(7) * 6주 = 42 임. 이건 viewDidLoad안에 갯수 지정하는 setWeekView() 에서 초기화된다
        totalSquares.count
    }
    
    
    
    func setWeekView(){
        
        // 일단 지우고,
        totalSquares.removeAll()

        var current = CalenderHelper().sundayForDate(date: selectedDate)
        
        let nextSunday = CalenderHelper().addDays(date: current, days: 7)
        
        while(current < nextSunday){
            
            totalSquares.append(current)
            current = CalenderHelper().addDays(date: current, days: 1)
        }

        // 달 - 년도 나오는 레이블 텍스트를 바꿈
        monthLabel.text = CalenderHelper().monthString(date: selectedDate) + " " + CalenderHelper().yearString(date: selectedDate)
        
        
        // 이거 안하면 업데이트가 안됨
        collectionView.reloadData()
        tableView.reloadData()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        //calCell 은 커스텀뷰의 identifier 임. 이걸로 각 cell 마다 index를 매겨주는거 같음
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
                
        let date = totalSquares[indexPath.item]
        
        
    
        
        cell.dayOfMonth.text = String(CalenderHelper().daysOfMonth(date: date))
        
        if(date == selectedDate){
            
            cell.backgroundColor = UIColor.systemBrown
        
        }else{
            
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedDate = totalSquares[indexPath.item]
        
 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        collectionView.reloadData()
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: -7)
        setWeekView() // 갯수 지정해주는 함수 재호출

    }
    
     
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    
    override open var shouldAutorotate: Bool{
        return false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return Event().eventsForDate(date: selectedDate).count
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        
        let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
        
        
        
        if(event.type == "입금"){

                    
            cell.eventLabel.text = event.type + " - " + event.name + " ( "  + CalenderHelper().timeString(date: event.date) +  " ) "
                        
            cell.priceLabel.attributedText = NSAttributedString(string: "₩ " + event.money, attributes:[NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 18) as Any])
            


            plusMoney = Int(event.money)!
            
            cell.test.text = "잔액    ₩" + String(accMoney + plusMoney)
            
            cell.eventLabel.textColor = UIColor.systemBlue


            minusMoney = 0
       }

        else{
            
            cell.eventLabel.text = event.type + " - " + event.name + " ( "  + CalenderHelper().timeString(date: event.date) +  " ) "
            
            cell.priceLabel.attributedText = NSAttributedString(string: "₩ " + event.money, attributes:[NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 18) as Any])
        
            
            minusMoney = Int(event.money)!
        
            
            cell.test.text = "잔액    ₩" + String(accMoney - minusMoney)
            
            
            cell.eventLabel.textColor = UIColor.systemRed
            
            plusMoney = 0

        }
        
        return cell
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            
            print(indexPath.item)
            
//            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
    }
    
    @IBAction func showEditing(_ sender: Any) {
        
        if(self.tableView.isEditing == true){
           
            self.tableView.isEditing = false
            self.navigationItem.title = "수정모드"
        }
        else{
            self.tableView.isEditing = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.navigationItem.title = "작성하기"

        }
    }
    
}
    
    
    
    
    
    

