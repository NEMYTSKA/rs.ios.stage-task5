import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }

    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    
    func one() -> Bool {
        return drinks.count == 1 && foods.count == 1
    }
    
    
    func plus(value: [Supply]) -> [Supply] {
        var res = [Supply]()
        for i in 0..<value.count-1 {
            var buff: Supply = value[i]
            for j in (i+1)..<value.count {
                buff.weight += value[j].weight
                buff.value += value[j].value
            }
            res.append(buff)
        }
        for i in 0..<value.count-1 {
            
            for j in (i+1)..<value.count {
                
                var buff: Supply
                buff.weight = value[i].weight + value[j].weight
                buff.value = value[i].value + value[j].value
                res.append(buff)
            }
        }
        return res
    }
    
    

    func findMaxKilometres() -> Int {
        if drinks.isEmpty || foods.isEmpty { return 0 }
        if one() {
            if (drinks[0].weight + foods[0].weight) > maxWeight { return 0 }
            return min(drinks[0].value, foods[0].value)
        }
        
        var foodsWithPlus = plus(value: foods)
        var drinksWithPlus = plus(value: drinks)
        
        
        foodsWithPlus += foods
        drinksWithPlus += drinks
        
        var allValueArray = [Supply]()
        
        for i in foodsWithPlus {
            for j in drinksWithPlus {
                var value: Supply
                value.weight = i.weight + j.weight
                value.value = min(i.value, j.value)
                allValueArray.append(value)
            }
        }
        let filterArray = allValueArray.filter { (i) -> Bool in
            i.weight <= maxWeight
        }
        let resultArray = filterArray.sorted { (i, j) -> Bool in
            i.value > j.value
        }
        
        
        return resultArray[0].value
    }

}
