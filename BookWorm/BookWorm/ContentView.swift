//
//  ContentView.swift
//  BookWorm
//
//  Created by Macbook Pro on 14/02/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    func deleteItem(use offset: IndexSet) {
        for offset in offset{
            let book = books[offset]
            
            moc.delete(book)
        }
        try? moc.save()
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(books){ book in
                    NavigationLink {
                        DetailView(book: book)
                        
                    } label : {
                        HStack {
                            EmojiReview(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknown Title" )
                                    .font(.headline)
                                
                                Text(book.author ?? "Jack")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }.onDelete(perform: deleteItem)
            }
            .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
