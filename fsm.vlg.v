module FigoFSM (
  input wire clk,        // Clock input
  input wire reset,      // Reset input
  input wire travel_plan, // Binary input representing the travel plan
  output reg [2:0] current_location // 3-bit binary representation of the current location
);

  // Define the states
  parameter [2:0] ROOM0 = 3'b000;
  parameter [2:0] ROOM1 = 3'b001;
  parameter [2:0] ROOM2 = 3'b010;
  parameter [2:0] ROOM3 = 3'b011;
  parameter [2:0] ROOM4 = 3'b100;
  parameter [2:0] ROOM5 = 3'b101;
  parameter [2:0] ROOM6 = 3'b110;
  parameter [2:0] ROOM7 = 3'b111;

  // Define the state register
  reg [2:0] state, next_state;

  // Define the state transition logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= ROOM0;
    end else begin
      state <= next_state;
    end
  end
  // Define the state output logic
  always @(state) begin
    case (state)
      ROOM0: current_location = 3'b000;
      ROOM1: current_location = 3'b001;
      ROOM2: current_location = 3'b010;
      ROOM3: current_location = 3'b001;
      ROOM4: current_location = 3'b100;
      ROOM5: current_location = 3'b101;
      ROOM6: current_location = 3'b110;
      ROOM7: current_location = 3'b111;
    endcase
  end

  // Define the next state logic
  always @(state, travel_plan) begin
    case (state)
      ROOM0: next_state = travel_plan ? ROOM1 : ROOM0;
      ROOM1: next_state = travel_plan ? ROOM2 : ROOM0;
      ROOM2: next_state = travel_plan ? ROOM3 : ROOM7;
      ROOM3: next_state = travel_plan ? ROOM7 : ROOM2;
      ROOM4: next_state = ROOM7;
      ROOM5: next_state = ROOM7;
      ROOM6: next_state = ROOM6;
      ROOM7: next_state = ROOM6;
    endcase
  end module
