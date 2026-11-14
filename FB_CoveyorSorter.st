rtStart(CLK := xStart);
rtReset(CLK := xReset);

rtOpticalSensor(CLK := xOpticalSensor);
rtInductiveSensor(CLK := xInductiveSensor);

// cylinder timeout check with limit switch
tonCylinderTimeout(
	IN := (
		(eConveyorState = E_ConveyorState.DIVERT_EXTEND AND NOT xCylinderOutLS) OR 
		(eConveyorState = E_ConveyorState.DIVERT_RETRACT AND xCylinderInLS)),
	PT := tCylinderTimeout
);

IF tonCylinderTimeout.Q THEN
	eConveyorState := E_ConveyorState.FAULT;
END_IF


CASE eConveyorState OF
	// STOP
	E_ConveyorState.STOP:
		xConveyorMotor := FALSE;
		xCylinderExtend := FALSE;
		
		IF rtStart.Q THEN
			eConveyorState := E_ConveyorState.RUN;
		END_IF
		
	// RUN
	E_ConveyorState.RUN:
		xConveyorMotor := TRUE;
		
		// count packages
		IF rtOpticalSensor.Q THEN
			GVL_Counter.udiTotalPackages :=
				GVL_Counter.udiTotalPackages + 1;
		
			IF xInductiveSensor THEN
				GVL_Counter.udiMetalPackages :=
					GVL_Counter.udiMetalPackages + 1;
			END_IF
		END_IF
		
	// DIVERT EXTEND
	E_ConveyorState.DIVERT_EXTEND:
		xConveyorMotor := FALSE;
		xCylinderExtend := TRUE;
		
		IF xCylinderOutLS THEN
			eConveyorState := E_ConveyorState.DIVERT_RETRACT;
		END_IF
		
	// DIVERT RETRACT
	E_ConveyorState.DIVERT_RETRACT:
		xConveyorMotor := FALSE;
		xCylinderExtend := FALSE;
		
		IF NOT xCylinderInLS THEN
			eConveyorState := E_ConveyorState.RUN;
		END_IF
		
	// FAULT
	E_ConveyorState.FAULT:
		xConveyorMotor := FALSE;
		xCylinderExtend := FALSE;
	
		IF rtReset.Q AND NOT xCylinderInLS THEN
			eConveyorState := E_ConveyorState.STOP;
		END_IF
		
END_CASE
