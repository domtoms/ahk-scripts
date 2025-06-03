#SingleInstance force

; Allows the spacebar to be double pressed to insert a period (like MacOS)

TimeWindow    := 200         ; Maximum time window for double pressing spacebar
LastInputKeys := []          ; List of the last 3 previously used keys
LastInputTime := A_TickCount ; Total ticks since the last keyboard input
Loop {
	; Listen for the next keyboard input
	Hook := InputHook("VL1")
	Hook.Start()
	Hook.Wait()

	; Calculate time since last keyboard input
	Elapsed := A_TickCount - LastInputTime
	LastInputTime := A_TickCount

	; Write to history list
	LastInputKeys.Insert(Hook.Input)
	if (LastInputKeys.MaxIndex() > 3) {
		LastInputKeys.RemoveAt(1)
	}

	; If last two keys are spaces and the key before isn't, add a period
	if (LastInputKeys[1] != " "
	 && LastInputKeys[2]  = " "
	 && LastInputKeys[3]  = " "
	 && Elapsed < TimeWindow) {
		Send, % "{BS 2}. "
	}
}
