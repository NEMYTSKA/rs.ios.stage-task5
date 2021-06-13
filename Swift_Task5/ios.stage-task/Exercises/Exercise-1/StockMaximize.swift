import Foundation

class StockMaximize {

    
    func countProfit(prices: [Int]) -> Int {
        
        guard prices.count > 1 else { return 0 }
        
        var myPrices = prices
        var result = 0
        
        func filtrMyPrices(_ value: inout [Int]) {
            for i in value {
                if i == value.max() {
                    value.remove(at: 0)
                } else {
                    break
                }
            }
        }
        
        filtrMyPrices(&myPrices)
        
        
        while myPrices.count > 1  {
            result += myPrices.max()! - myPrices[0]
            myPrices.remove(at: 0)
            filtrMyPrices(&myPrices)
        }
        
        return result
    }
}
