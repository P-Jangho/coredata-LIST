import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State private var item = ""
    
    var body: some View {
        Form {
            Section() {
                TextField("LIST入力", text: $item)
            }
        }
        .navigationTitle("LIST追加")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("保存") {
                    /// タスク新規登録処理
                    let newItem = Item(context: context)
                    newItem.timestamp = Date()
                    newItem.checked = 0
                    newItem.name = item
                    
                    try? context.save()
 
                    /// 現在のViewを閉じる
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
