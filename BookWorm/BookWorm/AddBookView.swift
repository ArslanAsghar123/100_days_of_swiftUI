//
//  AddBookView.swift
//  BookWorm
//
//  Created by Macbook Pro on 14/02/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy","Horror","Kids","Mystery","Poetry","Romance","Thriller"]

    var body: some View {

        NavigationView {
            Form {
                Section {
                    TextField("Book title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres,id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)

                } header: {
                    Text("Write A Review")
                }
                
                Section {
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.title = title
                        newBook.id = UUID()
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        do {
                            try self.moc.save()
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
