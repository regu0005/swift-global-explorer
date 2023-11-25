//
//  NetUI.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-24.
//

import SwiftUI

struct NetUI: View {
    @EnvironmentObject var networkMonitor : NetworkMonitor
    
    var body: some View {
        //NavigationView{
            if networkMonitor.isConnected {
                //Text("Network is connected")
                ContentView()
            }
            else
            {
                ContentUnavailableView("No network",
                                       systemImage: "wifi.exclamationmark",
                                       description: Text("Check your data or wifi")
                )
            }
        //}
    }
}
