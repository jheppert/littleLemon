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
    @State private var filterCategory = ""
    @FocusState var isSearchFocused: Bool
        
    var body: some View {
        VStack {
            VStack {
                Hero()
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .focused($isSearchFocused)
            }
            .background(Color("brandGreen"))
            .onChange(of: isSearchFocused) { oldValue, newValue in
                if newValue == true {
                    filterCategory = ""
                }
                print("Focus: \(newValue)")
            }
            
            VStack(alignment: .leading) {
                Text("Order for delivery!")
                    .font(.title3)
                    .fontWeight(.bold)
                ScrollView(.horizontal) {
                    HStack {
                        Button(action: {
                            searchText = ""
                            filterCategory = ""
                            isSearchFocused = false
                        }, label: {
                            Text("All Items")
                        })
                        .padding(EdgeInsets(top:8, leading: 16, bottom: 10, trailing: 16))
                        .background(filterCategory == "" ? Color("brandYellow") : Color("lightBackground"))
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .foregroundStyle(.black)
                        
                        Button(action: {
                            searchText = ""
                            filterCategory = "starters"
                            isSearchFocused = false
                        }, label: {
                            Text("Starters")
                        })
                        .padding(EdgeInsets(top:8, leading: 12, bottom: 10, trailing: 12))
                        .background(filterCategory == "starters" ? Color("brandYellow") : Color("lightBackground"))
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .foregroundStyle(.black)
                        
                        Button(action: {
                            searchText = ""
                            filterCategory = "mains"
                            isSearchFocused = false
                        }, label: {
                            Text("Mains")
                        })
                        .padding(EdgeInsets(top:8, leading: 12, bottom: 10, trailing: 12))
                        .background(filterCategory == "mains" ? Color("brandYellow") : Color("lightBackground"))
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .foregroundStyle(.black)
                        
                        Button(action: {
                            searchText = ""
                            filterCategory = "desserts"
                            isSearchFocused = false
                        }, label: {
                            Text("Desserts")
                        })
                        .padding(EdgeInsets(top:8, leading: 12, bottom: 10, trailing: 12))
                        .background(filterCategory == "desserts" ? Color("brandYellow") : Color("lightBackground"))
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .foregroundStyle(.black)
                        
                        Button(action: {
                            searchText = ""
                            filterCategory = "drinks"
                            isSearchFocused = false
                        }, label: {
                            Text("Drinks")
                        })
                        .padding(EdgeInsets(top:8, leading: 12, bottom: 10, trailing: 12))
                        .background(filterCategory == "drinks" ? Color("brandYellow") : Color("lightBackground"))
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .foregroundStyle(.black)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            
            Divider()
            
            // MARK: Fetch Objects
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List(dishes) { dish in
//                    ForEach(dishes) { dish in
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("\(dish.title ?? "Unknown dish")")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                Text("\(dish.dishDescription ?? "")")
                                Text("$\(dish.price ?? "")")
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                .frame(width: 100, height: 100)
                        }
//                    }
                }
                .listStyle(.plain)
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
        if searchText == "" && filterCategory == "" { // Both empty
            return NSPredicate(value: true)
        } else if searchText == "" && filterCategory != "" { // Only filter by category
            return NSPredicate(format: "category CONTAINS %@", filterCategory)
        } else { // Only search
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
                    dish.dishDescription = item.dishDescription
                    dish.category = item.category
                }
                try? viewContext.save()
            }
        }
        task.resume()
        
    }
    
}

#Preview {
    Menu()
}
