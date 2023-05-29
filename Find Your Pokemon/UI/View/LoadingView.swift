//
//  LoadingView.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            ProgressView()
            Text("Getting data ...")
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
