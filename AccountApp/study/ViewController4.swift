//
//  ViewController4.swift
//  AccountApp
//
//  Created by 김희진 on 2021/07/17.
//

import UIKit

class ViewController4: UIViewController {

    // 타이머가 구동되면 실행할 함수 -> 타이머가 작동할때마다 updateTime 을 작동시킨다 -> 그레서 selector 을 사용한다
    let timeSelector: Selector = #selector(ViewController4.updateTime)
    // 타이머의 간격 1초
    let interval = 1.0
    // 타이머가 제대로 작동하는지 확인하는 변수
    var count = 0
    
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()  

        // 이걸로 타이머가 구동되면 13번째줄의 함수(timeSelector)가 실행된다
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        // 전달된 인수 저장
        let datePickeView = sender

        //날짜를 출력하기 위해 클래스 상수 선언
        let formatter = DateFormatter()

        //데이터 포맷속성 지정
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"

        //선택한날짜를 원한는 포맷으로 변환해서 선택시간 레이블의 text를 바꾼다.
        lblPickerTime.text = "선택시간 : " + formatter.string(from: datePickeView.date)

    }
    
    
    // 이벤트바인드용 함수가 아니라 이렇게 #selector() 의 인자로 사용될 메소드를 만들때 @objc 어노테이션을 이용한다 -> object-C 와 호환성 높음
    // 타이머가 구동된 후 정해진 시간이 되었을떄 실행할 함수
    @objc func updateTime(){
    
        // 테스트용 카운트
        // lblCurrentTime.text = String(count)
        // count = count + 1
    
        // 현재시간
        let date = NSDate()
        
        // 날짜를 출력하기 위하여 DateFormatter 라는 클래스의 상수 formatter 을 선언
        let formatter = DateFormatter()
        
        // formatter의 속성결정
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)
    
    }
    

}
