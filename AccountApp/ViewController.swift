import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
      
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
        
    var totalSquares = [String]()
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        // 초기화 함수도 이때 호출한다
        setCellsView() // 크기지정
        setMonthView() // 갯수지정

    }
    

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        collectionView.reloadData()
        print(eventsList)

    }

    
    
    //custom view인 CalenderCell 을 
    func setCellsView(){
        
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as UICollectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        

    }
    
    
    
    // 컬렉션뷰를 매핑해줬음
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //print(totalSquares.count)
        //함수에 아무내용 없이 바로 리턴해줄때는 return 생략해도됨
        //이거 출력해보면 42 가 나오는데, 월~일(7) * 6주 = 42 임. 이건 viewDidLoad안에 갯수 지정하는 setMonthView() 에서 초기화된다
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        //calCell 은 커스텀뷰의 identifier 임. 이걸로 각 cell 마다 index를 매겨주는거 같음
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        cell.isUsedButton.isHidden = true
        
        
        // 현재시간
        let now = NSDate()
        
        
        if(cell.dayOfMonth.text == CalenderHelper().dayString(date: now as Date)){

            cell.backgroundColor = UIColor.systemBrown

        }else{

            cell.backgroundColor = UIColor.white
        }
        

        // 수정 -> 가격 입력하는거 전부 버튼 뜨게 하고 -> viewController table view 만들어서 입력된 그날짜의 이벤트 전부 띄우게
        if(totalSquares[indexPath.item] != ""){
            
            if (eventsList.count > 0 ){
                
                let idx = eventsList.first(where: {CalenderHelper().dayString(date: $0.date) == totalSquares[indexPath.item] })
                
                let temp = idx?.id!
                
                if let realIdx = temp{
                    let time = eventsList[realIdx].date!
                    if(totalSquares[indexPath.item] == CalenderHelper().dayString(date: time)){
                        cell.isUsedButton.isHidden = false
                    }

                }
                            
            }
        }
        
        
        return cell
    }

    
    
    
    func setMonthView(){
        
        // 일단 지우고,
        totalSquares.removeAll()
        
        //calenderHelper 클래스의 메소드를 오버라이딩 해서 사용한다
        let daysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalenderHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalenderHelper().weekDay(date: firstDayOfMonth)
        
        
        // 일단 1로 초기화
        var count: Int = 1
        
        // 일단 42칸 먹음
        while(count <= 42){
            
            if(count <= startingSpaces || count - startingSpaces > daysInMonth){
                totalSquares.append("")
                
            } else{
                totalSquares.append(String(count - startingSpaces))
            }
            
            count += 1
            
        }
        
        // 달 - 년도 나오는 레이블 텍스트를 바꿈
        monthLabel.text = CalenderHelper().monthString(date: selectedDate) + " " + CalenderHelper().yearString(date: selectedDate)
        
        
        // 이거 안하면 업데이트가 안됨
        collectionView.reloadData()
    }
    
    
    
    
    
    
    @IBAction func previosMonth(_ sender: Any) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setMonthView() // 갯수 지정해주는 함수 재호출
    }
    
    
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }

    
    //뷰컨트롤러 회전이라는데,, 뭔소린지 모르겠음 .. 기본이 true 라는데
    override open var shouldAutorotate: Bool{
        return false
    }
    

    
    @IBAction func detailButton(_ sender: Any) {
        let data : String = "!!!!!"
        
        
        
        let ViewController6 = self.storyboard?
            .instantiateViewController( withIdentifier:
                                        "ViewController6") as! ViewController6

//        let a = Int(CalenderHelper().dayString(date: selectedDate))
//        print(CalenderHelper().dayString(date: selectedDate))
//        print(eventsList[a!])
//        eventsList[CalenderHelper().dayString(date: selectedDate)]).money
        
//        print(String(eventsList[CalenderHelper().dayString(date: selectedDate)]).money)
        ViewController6.result = data

        self.present(ViewController6, animated: true, completion: nil)
    }

 

    
//  생명주기
//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        print("viewDidAppear")
//
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        print("viewDidDisappear")
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        print("viewWillDisappear")
//
//    }


}

