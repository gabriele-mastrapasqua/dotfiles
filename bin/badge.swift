import AppKit

let args = CommandLine.arguments
let label = args.count > 1 ? args[1] : ""

let app = NSApplication.shared
app.dockTile.badgeLabel = label
app.dockTile.display()
// Keep alive briefly so the dock updates
RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
