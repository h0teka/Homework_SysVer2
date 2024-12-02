//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests
(
    input        clk,
    input        rst,
    input  [1:0] requests,
    output [1:0] grants
);
    // Task:
    // Implement a "arbiter" module that accepts up to two requests
    // and grants one of them to operate in a round-robin manner.
    //
    // The module should maintain an internal register
    // to keep track of which requester is next in line for a grant.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    //
    // Example:
    // requests -> 01 00 10 11 11 00 11 00 11 11
    // grants   -> 01 00 10 01 10 00 01 00 10 01

 logic last_granted_high;

  logic [1:0] next_grants;

  always_comb begin
    case (requests)
      2'b00:   next_grants = 2'b00;                 // Нет запросов
      2'b01:   next_grants = 2'b01;                 
      2'b10:   next_grants = 2'b10;                
      2'b11:   next_grants = last_granted_high ? 
                               2'b01 : 2'b10;      
    endcase
  end

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      last_granted_high <= 1'b0;                    // Сброс к начальному состоянию
    end else if (|requests) begin                   // Если активен хотя бы один запрос
      last_granted_high <= next_grants[1];          // Сохранение, кому был выдан грант
    end
  end

  assign grants = next_grants;
endmodule
