//
//  SkeletonListView.swift
//  Mobile Challenge city Uala
//
//  Created by Nicolas Dolinkue on 22/03/2025.
//

import SwiftUI

struct SkeletonListView: View {
    var body: some View {
        List(0..<10, id: \.self) { _ in
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 12)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 12)
                }
                .padding(.leading, 10)
            }
            .redacted(reason: .placeholder)
        }
    }
}
