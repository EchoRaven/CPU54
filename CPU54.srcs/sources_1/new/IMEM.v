`timescale 1ns / 1ps
module IMEM (
    input  [10:0] IM_addr,
    output [31:0] IM_instr
);
always@(IM_addr)
begin
end
  dist_mem_gen_0 dist_mem_gen_0_init (
      .a  (IM_addr),
      .spo(IM_instr)
  );
endmodule
