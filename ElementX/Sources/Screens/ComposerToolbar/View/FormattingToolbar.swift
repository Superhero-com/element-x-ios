//
// Copyright 2023 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct FormattingToolbar: View {
    /// The list of items to render in the toolbar
    var formatItems: [FormatItem]
    /// The action when an item is selected
    var formatAction: (FormatType) -> Void

    @ScaledMetric private var toolbarButtonIconSize = 24

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                ForEach(formatItems) { item in
                    Button {
                        formatAction(item.type)
                    } label: {
                        item.icon
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: toolbarButtonIconSize, height: toolbarButtonIconSize)
                            .foregroundColor(item.foregroundColor)
                            .padding(10)
                    }
                    .disabled(item.state == .disabled)
                    .background(item.backgroundColor)
                    .cornerRadius(8)
                    .accessibilityIdentifier(item.accessibilityIdentifier)
                    .accessibilityLabel(item.accessibilityLabel)
                }
            }
        }
    }
}

private extension FormatItem {
    var foregroundColor: Color {
        switch state {
        case .reversed:
            return .compound.iconOnSolidPrimary
        case .enabled:
            return .compound.iconSecondary
        case .disabled:
            return .compound.iconDisabled
        }
    }

    var backgroundColor: Color {
        switch state {
        case .reversed:
            return .compound.bgActionPrimaryRest
        default:
            return .compound.bgCanvasDefault
        }
    }
}
