//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module halve_tokens
(
    input  clk,
    input  rst,
    input  a,
    output b
);
    // Task:
    // Implement a serial module that reduces amount of incoming '1' tokens by half.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    //
    // Example:
    // a -> 110_011_101_000_1111
    // b -> 010_001_001_000_0101

  typedef enum logic {
    PASS_ONE = 1'b0,       // состояние, в котором единица проходит на выход
    REPLACE_ONE = 1'b1     // состояние, в котором единица заменяется на ноль
  } state_t;

  state_t state;

  assign b = (a) & (state == PASS_ONE);

  // Логика пеехода состояний
  always_ff @(posedge clk) begin
    if (rst) 
      state <= REPLACE_ONE;   
    else if (a) 
      state <= (state == REPLACE_ONE) ? PASS_ONE : REPLACE_ONE;  
  end

endmodule
