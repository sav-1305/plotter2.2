# Real-Time Data Plotter
---
## Objective
Design and Implement an application to display and record real-time flight data, oriented to the flight of a Sounding Rocket providing data objects inclusive of ```Timestamp```, ```Altitude```, ```Pressure```, ```Velocity```, ```three-axis acceleration and gyroscope readings```, and ```GPS data```. The application should feature a GUI and be capable of:
- Plotting real-time graphs from Serial Data
- Displaying and recording the data points in local storage
- Providing a test-view where functionalities can be displayed via sample flight data

## CHANGELOG
| version | date | comment |
| ------- | ---- | ------- |
| 1.0 | 09-03-2025 | Initial Commit.<br> - Altitude plot in main.dart file |
| 1.1 | 10-03-2025 | Add Widgets.<br> - Added widget for single graph (graph_widget) <br> - Plots for Altitude, Velocity, and Pressure |
| 2.0 | 13-03-2025 | Add multiple views.<br> - Added Dashboard for graphs and port view for raw data <br> - Added Drawer to switch between port view and dashboard |
| 2.1 | 14-03-2025 | Add 3-axis Acceleration Graph |
| 2.2 | 15-03-2025 | - Stylize Dashboard <br> - Retain current index between dashboard and port view |
