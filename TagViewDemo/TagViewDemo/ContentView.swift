//
//  ContentView.swift
//  TagViewDemo
//
//  Created by Thongchai Subsaidee on 6/9/2564 BE.
//

import SwiftUI
import LoremSwiftum

struct ContentView: View {
        
//    let words = [
//        "Action movie are good",
//        "Horror on",
//        "🐇",
//        "IT 2",
//        "Comedy is good",
//        "Adventure Park",
//        "Kids",
//        "Science Fictoion",
//        "Drama",
//        "Romance",
//        "ET",
//        "Sliicon valley",
//        "Fantary"
//    ]
    
    let words = Lorem.words(150).split(separator: " ").map{String($0)}
    

    var body: some View {
        
        TagsView(items: words)
 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TagsView: View {

    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]) {
        self.items = items
        self.groupedItems = createGroupedItems(items: items)
    }
    
    private func createGroupedItems(items: [String]) -> [[String]] {
        
        var groupedItems: [[String]] = [[String]]()
        var tempItems: [String] = [String]()
        var width: CGFloat = 0
        
        for word in items {
            
            let label = UILabel()
            label.text = word
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 32
            
            if (width + labelWidth + 55) < screenWidth {
                width += labelWidth
                tempItems.append(word   )
            }else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
            
        }
        
        groupedItems.append(tempItems)
        return groupedItems
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(groupedItems, id: \.self) { subItems in
                    HStack {
                        ForEach(subItems, id: \.self ) { word in
                            Text(word)
                                .fixedSize()
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                .onTapGesture {
                                    
                                }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
