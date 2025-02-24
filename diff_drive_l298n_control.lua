local K_THROTTLE = 3
local K_STEERING = 1
local RELAY_LEFT_FWD = 3
local RELAY_LEFT_REV = 4
local RELAY_RIGHT_FWD = 5
local RELAY_RIGHT_REV = 6

local SERVO_LEFT_REVERSED = Parameter()
local SERVO_RIGHT_REVERSED = Parameter()

SERVO_LEFT_REVERSED:init('SERVO1_REVERSED')
SERVO_RIGHT_REVERSED:init('SERVO2_REVERSED')

-- Define PWM ranges
local PWM_NEUTRAL_MIN = 1490
local PWM_NEUTRAL_MAX = 1510
local PWM_FORWARD_MIN = 1511
local PWM_FORWARD_MAX = 2000
local PWM_REVERSE_MIN = 1000
local PWM_REVERSE_MAX = 1489

function update()
  if arming:is_armed() == false then
    return update, 50
  end
  
  local current_throttle = rc:get_pwm(K_THROTTLE)
  local current_steering = rc:get_pwm(K_STEERING)

  -- Stop Motors if Throttle is Neutral
  if current_throttle >= PWM_NEUTRAL_MIN and current_throttle <= PWM_NEUTRAL_MAX then
    relay:off(RELAY_LEFT_FWD)
    relay:off(RELAY_LEFT_REV)
    relay:off(RELAY_RIGHT_FWD)
    relay:off(RELAY_RIGHT_REV)
    gcs:send_text(3, "Motors Stopped")
  elseif current_throttle >= PWM_FORWARD_MIN and current_throttle <= PWM_FORWARD_MAX then
    -- Forward
    relay:on(RELAY_LEFT_FWD)   -- Activate left motor forward
    relay:off(RELAY_LEFT_REV)  -- Ensure left motor reverse is off
    relay:on(RELAY_RIGHT_FWD)  -- Activate right motor forward
    relay:off(RELAY_RIGHT_REV) -- Ensure right motor reverse is off
    gcs:send_text(3, "Moving Forward")
  elseif current_throttle >= PWM_REVERSE_MIN and current_throttle <= PWM_REVERSE_MAX then
    -- Reverse
    relay:off(RELAY_LEFT_FWD)  -- Ensure left motor forward is off
    relay:on(RELAY_LEFT_REV)   -- Activate left motor reverse
    relay:off(RELAY_RIGHT_FWD) -- Ensure right motor forward is off
    relay:on(RELAY_RIGHT_REV)  -- Activate right motor reverse
    gcs:send_text(3, "Moving Backward")
  else
    -- Invalid PWM value (fallback to neutral)
    relay:off(RELAY_LEFT_FWD)
    relay:off(RELAY_LEFT_REV)
    relay:off(RELAY_RIGHT_FWD)
    relay:off(RELAY_RIGHT_REV)
    gcs:send_text(3, "Invalid Throttle PWM")
  end

  -- Steering Control
  if current_steering >= 1490 and current_steering <= 1510 then
    gcs:send_text(3, "Going Straight")
  elseif current_steering < 1490 then
    -- Turn Left (Stop Left Motor, Move Right Motor Forward)
    relay:off(RELAY_LEFT_FWD)  -- Stop left motor
    relay:off(RELAY_LEFT_REV)  -- Ensure left motor reverse is off
    relay:on(RELAY_RIGHT_FWD)  -- Move right motor forward
    relay:off(RELAY_RIGHT_REV) -- Ensure right motor reverse is off
    gcs:send_text(3, "Turning Left")
  else
    -- Turn Right (Stop Right Motor, Move Left Motor Forward)
    relay:on(RELAY_LEFT_FWD)   -- Move left motor forward
    relay:off(RELAY_LEFT_REV)  -- Ensure left motor reverse is off
    relay:off(RELAY_RIGHT_FWD) -- Stop right motor
    relay:off(RELAY_RIGHT_REV) -- Ensure right motor reverse is off
    gcs:send_text(3, "Turning Right")
  end

  return update, 50
end

return update()