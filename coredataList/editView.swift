import SwiftUI
import WebKit

struct editView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    var item: Item
    @State var name: String = ""
    
    var body: some View {
        VStack{
            Form {
                Section() {
                    TextField("name", text: self.$name)
                }
            }
            .navigationTitle("LIST編集")
            .onAppear(perform: {
                self.name = self.item.name!
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("編集") {
                        self.item.name = self.name
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
