//
//  ContentView.swift
//  devhub
//
//  Created by Chanakan Mungtin on 16/3/2567 BE.
//

import SwiftUI
import SwiftData
import SwiftDown

extension Bool {
    var negated: Bool { !self }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items.reversed()) { item in
                    @Bindable var item = item
                    NavigationLink {
                        SwiftDownEditor(text: $item.text)
                            .insetsSize(16)
                            .theme(colorScheme == .dark ? Theme.BuiltIn.defaultDark.theme() : Theme.BuiltIn.defaultLight.theme())
                    } label: {
                        VStack(alignment: .leading) {

                            if(item.text.filter(\.isWhitespace.negated).isEmpty) {
                                Text("No Title")
                            } else {
                                Text(item.text.components(separatedBy: CharacterSet.newlines).first!.replacingOccurrences(of: "# ", with: "").trimmingCharacters(in: .whitespaces))
                            }
                                
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard)).font(.footnote)
                        }.frame(alignment: .leading)
                    }
                    
                }
                
                .onDelete(perform: deleteItems)
                
            }
            
#if os(macOS)
            
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            
#endif
            
            .toolbar {
                
#if os(iOS)
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    EditButton()
                    
                }
                
#endif
                
                ToolbarItem {
                    
                    Button(action: addItem) {
                        
                        Label("Add Item", systemImage: "plus")
                        
                    }
                    
                }
                
            }
            
        } detail: {
            
            Text("Select an item")
            
        }
        
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
