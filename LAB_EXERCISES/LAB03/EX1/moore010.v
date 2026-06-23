module moore010(
	input CLK, RST, DataIn, 
	output Out
);
	reg [1:0] State;
	reg [1:0] Next_State;
	
	parameter State0 = 2'b00;
	parameter State1 = 2'b01;
	parameter State2 = 2'b10;
	parameter State3 = 2'b11;
	
	always @(State or DataIn) begin 
		case (State)
			State0:
				if (DataIn)
					Next_State = State0;
				else
					Next_State = State1;
			State1:
				if (DataIn)
					Next_State = State2;
				else
					Next_State = State1;
			State2:
				if (DataIn)
					Next_State = State0;
				else
					Next_State = State3;
			State3:
				if (DataIn)
					Next_State = State2;
				else
					Next_State = State1;
			default:
					Next_State = State0;
		endcase
	end
	
	always @(posedge CLK) begin
		if (RST == 1)
			State <= State0;
		else 
			State <= Next_State;
	end
	
	assign Out = (State == State3) ? 1:0;
endmodule
