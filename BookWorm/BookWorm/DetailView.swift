//
//  DetailView.swift
//  BookWorm
//
//  Created by Macbook Pro on 15/02/2022.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var showAlert = false
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
                
               
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book", isPresented: $showAlert){
            Button("Delete",role: .destructive,action: deleteBook)
            Button("Cancel",role: .cancel){}
        } message: {
            Text("Are you sure")
        }
        .toolbar{
            Button {
                showAlert = true
            } label: {
                Label("Delete this Book", systemImage: "trash")
            }
        }
    }
    func deleteBook(){
        moc.delete(book)
        
      try? moc.save()
        dismiss()
    }
}


