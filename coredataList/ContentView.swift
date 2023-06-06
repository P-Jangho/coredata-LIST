//
//  ContentView.swift
//  coredataList
//
//  Created by PJH on 2023/01/30.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        predicate: nil
    )
    
    private var items: FetchedResults<Item>
    
    @State var count: Int = 0
    
    @State private var birthDate = Date()
    
    var dateformat: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-M-d"
            return formatter
       }
    
    var body: some View {
        
            NavigationView {
                VStack {
                    
                    List {
                        ForEach(items) { item in
                            
                            let urlString = "https://www.google.com/search?q=\(item.name!)"
                            
                            let encodedString : String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
                            
                            Section(header:
                                        HStack {
                                Link("\(item.name!)",
                                         destination: URL(string:encodedString)!)
                                
                                Spacer()
                                
                                NavigationLink("編集", destination: editView(item: item, name: "\(item.name!)"))
                                
                            }, content: {
                                    Button(action: {
                                        item.checked += 1
                                        try? context.save()
                                        
                                        if item.checked == 6 {
                                            item.checked = 0
                                        }
                                    }) {
                                        HStack{
                                            if item.checked >= 1 {
                                                Image(systemName: "star.fill")
                                            }else{
                                                Image(systemName: "star")
                                            }
                                            
                                            if item.checked >= 2 {
                                                Image(systemName: "star.fill")
                                            }else{
                                                Image(systemName: "star")
                                            }
                                            
                                            if item.checked >= 3 {
                                                Image(systemName: "star.fill")
                                            }else{
                                                Image(systemName: "star")
                                            }
                                            
                                            if item.checked >= 4 {
                                                Image(systemName: "star.fill")
                                            }else{
                                                Image(systemName: "star")
                                            }
                                            
                                            if item.checked >= 5 {
                                                Image(systemName: "star.fill")
                                            }else{
                                                Image(systemName: "star")
                                            }
                                            
                                            Spacer()
                                            
                                            Text("\(item.timestamp!, formatter: dateformat) 保存")
                                                .opacity(0.3)
                                        }
                                    }
//                               .contentShape(Rectangle())
//                               .onTapGesture {
//                                   item.checked.toggle()
//                                   try? context.save()
//                               }
                            })
                        }
                        .onDelete(perform: deleteTasks)
                    }
                    .listStyle(InsetListStyle())
                    .navigationTitle("LIST")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddTaskView()) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
        }
    
        /// タスクの削除、 Parameter offsets: 要素番号のコレクション
        func deleteTasks(offsets: IndexSet) {
            for index in offsets {
                context.delete(items[index])
            }
            try? context.save()
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
