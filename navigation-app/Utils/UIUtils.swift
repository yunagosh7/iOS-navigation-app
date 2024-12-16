//
//  GetStars.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 16/12/2024.
//

class UIUtils {
    
    static let shared: UIUtils = {
        let instance = UIUtils()
        return instance
    }()
    
    func getFilledStars(score: Float) -> [StarItem] {
        var arr: [StarItem] = []
        var scoreCopy = score
        
        for i in 1...5 {
            var itemState: StarState
            if scoreCopy >= 1 {
                itemState = .filled
                scoreCopy -= 1
            } else if scoreCopy >= 0.75 {
                itemState = .filled
                scoreCopy = 0
            } else if scoreCopy >= 0.25 {
                itemState = .half
                scoreCopy = 0
            } else {
                itemState = .empty
                scoreCopy = 0
            }
            arr.append(StarItem(id: i, state: itemState))
        }
        
        return arr
    }
    
    
    enum StarState {
        case filled
        case half
        case empty
    }
    
    struct StarItem : Identifiable {
        let id: Int
        let state: StarState
    }

}
