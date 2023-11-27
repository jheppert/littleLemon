//
//  Menu.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/25/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("This is a description of the whole application")
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title ?? "") $\(dish.price ?? "")")
                            Spacer()
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .onAppear() {
                getMenuData()
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let stringData = String(data: data, encoding: .utf8) {
                print(stringData)
                let decoder = JSONDecoder()
                let result = try? decoder.decode(MenuList.self, from: data)
                for item in result?.menu ?? [] {
                    let dish = Dish(context: viewContext)
                    dish.title = item.title
                    dish.image = item.image
                    dish.price = item.price
                }
//                result?.menu.forEach({ item in
//                    let dish = Dish()
//                    dish.title = item.title
//                    dish.image = item.image
//                    dish.price = item.price
//                })
                try? viewContext.save()
            }
        }
        task.resume()
        
    }
    
}

#Preview {
    Menu()
}
