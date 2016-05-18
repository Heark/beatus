var Gavin = require('cylon');


Gavin.robot({
  connections: {
    keyboard: { adaptor: 'keyboard' }
    raspi: { adaptor: 'raspi' }
  },

  devices: {
    keyboard: { driver: 'keyboard' }
    led: { driver: 'led', pin: 11 }
    motor: { driver: 'motor', pin: 3 } // connect to motor
  },

  work: function(my) {
    // flash LED if motor is on
    function flashMotor() {
      if(my.motor.isOn == true) {
        my.led.toggle();
      } else {
        if(my.led.isOn == true) {
          my.led.toggle()
        } else {
          console.log("Motor is off.")
        }
      }
    }
    my.keyboard.on('v', function(key){
      my.motor.toggle() // Toggle motor on or off
    })
    
    var $MOTORSPEED = 10;
    my.keyboard.on('w', function(key) {
      $MOTORSPEED++
      console.log("Motor speed set at "+$MOTORSPEED);
    })
    my.keyboard.on('s', function(key) {
      $MOTORSPEED--
      console.log("Motor speed set at "+$MOTORSPEED);
    })
    my.motor.speed($MOTORSPEED);
    
    my.keyboard.on('a', function(key) {
      my.motor.stop();
    });
    every((1).second(), flashMotor()) // Flash LED when motor is on
    
  }
}).start();
