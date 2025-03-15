# Differential Drive ArduRover with L298N Motor Driver-Ardupilot
Pixhawk integration with L298N Motor driver

This repository provides an updated and improved version of the [original project](https://github.com/jazzl0ver/ardupilot-rover-l298n), adapting it for a **differential drive** robot and updating it for the latest ArduPilot version. The project enables controlling a differential drive rover using a **Pixhawk flight controller** and an **L298N motor driver**.

## Features

- **Supports Differential Drive**: Adapted from RC Car setup.
- **Updated for Latest ArduPilot**: Uses current firmware versions.
- **Pre-configured Parameters**: Ready-to-use `.param` file for easy setup.
- **Lua Scripting for Automation**: Includes a `.lua` script to enhance motor control.

## Components Required

- **Pixhawk Flight Controller** (Tested with Pixhawk 2.4.8)
- **L298N Motor Driver**
- **Two DC Motors** (For differential drive)
- **Power Module** (Regulated power supply)
- **Battery Pack** (Sufficient for Pixhawk and motors)
- **MicroSD Card** (For Lua scripting)

## Wiring Diagram

| L298N Pin | Pixhawk Connection |
|-----------|--------------------|
| IN1       | AUX3              |
| IN2       | AUX4              |
| IN3       | AUX5              |
| IN4       | AUX6              |
| ENA       | PWM1              |
| ENB       | PWM2              |
| GND       | Pixhawk GND       |
| Vcc       | Power Module      |

### **Motor Connections**
- **Motor A**: Left drive motor.
- **Motor B**: Right drive motor.

## ArduPilot Parameter Configuration

A **parameter file** (`DiffDrive_Parameters.param`) is included to simplify the setup. To apply the parameters:

1. Connect the **Pixhawk** to your PC and open **Mission Planner**.
2. Navigate to **Config/Tuning > Full Parameter List**.
3. Load the `DiffDrive_Parameters.param` file.
4. Write the parameters to the Pixhawk.

### **Key Parameters**
- **BRD_PWM_COUNT** = `2` (Allocates AUX pins for relay)
- **BRD_SAFETYENABLE** = `0` (Disables safety switch)
- **MOT_PWM_TYPE** = `3` (BrushedWithRelay mode)
- **SCR_ENABLE** = `1` (Enable Lua scripting)
- **SERVO1_FUNCTION** = `26` (Steering)
- **SERVO1_TRIM** = `1494`
- **RELAY_PIN Assignments**: AUX1 - AUX6 used for motor control.

## Lua Script Integration

The included **Lua script** (`set_rotation_dir.lua`) helps manage motor direction and behavior. To enable it:

1. Insert a **microSD card** into the Pixhawk.
2. Create a folder named `scripts` in the **root** of the SD card.
3. Copy `set_rotation_dir.lua` into the `scripts` folder.
4. Ensure **SCR_ENABLE = 1** in ArduPilot parameters.

## Installation Steps

1. Flash **ArduRover** firmware onto the **Pixhawk**.
2. **Upload the parameter file** via Mission Planner.
3. **Place the Lua script** in the SD card under `/scripts/`.
4. **Connect motors & power** to the L298N and Pixhawk.
5. **Test and calibrate** using RC or MAVLink commands.

## References

- [ArduPilot Documentation](https://ardupilot.org/)
- [ArduPilot Lua Scripting Guide](https://ardupilot.org/copter/docs/common-lua-scripts.html)
- [ArduRover Motor Configuration](https://ardupilot.org/rover/docs/rover-motor-and-servo-configuration.html)

## Credits

- **Original RC Car Project**: [jazzl0ver](https://github.com/jazzl0ver/ardupilot-rover-l298n)
- **Modified & Updated for Differential Drive**: [Richard Albert K M](https://github.com/albertrichard080)

---

This repository makes it **easy to set up** and run an **ArduPilot-based differential drive rover** using Pixhawk & L298N. 🚀
