//
//  NetworkMonitor.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-24.
//

import Foundation
import Network
class NetworkMonitor: ObservableObject {
  private let networkMonitor = NWPathMonitor()
  private let workerQueue = DispatchQueue(label: "Monitor")
  var isConnected = false
  init() {
    networkMonitor.pathUpdateHandler = { path in
      self.isConnected = path.status == .satisfied
      Task {
        await MainActor.run {
          self.objectWillChange.send()
        }
      }
    }
    networkMonitor.start(queue: workerQueue)
  }
}
