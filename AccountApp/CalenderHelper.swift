import UIKit

class CalenderHelper {

    let calendar = Calendar.current
        
    
    // -> 뒤에 리턴타입 명시해준다 () 안에는 인자
    // Date components 다양하게 사용 가능
    func plusMonth(date: Date) -> Date
    {
        //print(date) // 2021-07-19 22:28:58 +0000
        //date 에서 month 에 +1 을 해라
        
        return calendar.date(byAdding: .month, value: 1, to:date)!
    }
    
    
    func minusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to:date)!
    }
    
    
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL" // 이렇게해야 월별로 잘보임, LLLL -> 풀네임
        return dateFormatter.string(from: date)
    }
  
    
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }


    func timeString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    func dayString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    
    
    // 한달에 몇일이 있는지 세줌
    func daysInMonth(date: Date) -> Int
    {
        // of : smaller
        // The smaller calendar component.

        // in : larger
        //The larger calendar component.

        // for : date
        //The absolute time for which the calculation is performed.
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        
        return range.count
    }

    
    //dateComponents 는 특정 날짜를 만들수있음
    func daysOfMonth(date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }

    
    // 전 달이 언제끝나는지 계산할 수 있음
    func firstOfMonth(date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }

    
    // 1일전에 몇일 빵꾸나는지 계산하는 방법임
    func weekDay(date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    
    func addDays(date: Date, days: Int) -> Date
    {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    
    
    func sundayForDate(date: Date) -> Date
        {
            var current = date
            let oneWeekAgo = addDays(date: current, days: -7)
            
            while(current > oneWeekAgo){
                
                let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
                
                if(currentWeekDay == 1){
                    return current
                }
                
                current = addDays(date: current, days: -1)
                
            }
            return current
        }
        
}
