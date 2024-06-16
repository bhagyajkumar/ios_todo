import SwiftUI
import Foundation

struct ToDoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct ContentView: View {
    @State private var toDoItems: [ToDoItem] = []
    @State private var newTaskTitle: String = ""
    @State private var showEmptyDialog: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {
                        Text("Add")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
                .padding()
                
                List {
                    ForEach(toDoItems) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            if item.isCompleted {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                            }
                        }
                        .onTapGesture {
                            toggleCompletion(for: item)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To-Do List")
            .alert(isPresented: $showEmptyDialog) {
                Alert(
                    title: Text("Cant be empty"),
                    dismissButton: .default(Text("ok"))
                )
            }
        }
    }
    
    private func addTask() {
        let newTask = ToDoItem(title: newTaskTitle, isCompleted: false)
        if newTaskTitle.isEmpty {
            showEmptyDialog = true
            return
        }
        toDoItems.append(newTask)
        newTaskTitle = ""
    }
    
    private func toggleCompletion(for item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isCompleted.toggle()
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        toDoItems.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
