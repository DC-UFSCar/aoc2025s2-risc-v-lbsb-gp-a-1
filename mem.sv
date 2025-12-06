module mem (
  input  logic        clk, we,
  input  logic [31:0] a, wd,
  output logic [31:0] rd,
  input  logic  [3:0] wm);

  logic  [31:0] RAM [0:255];

  // initialize memory with instructions or data
  initial
    $readmemh("riscv.hex", RAM);

  assign rd = RAM[a[31:2]]; // word aligned

  // Lógica de escrita corrigida para suportar SB, SH e SW
  always_ff @(posedge clk) begin
    if (we) begin
      // Byte 0 (bits 0-7)
      if (wm[0]) RAM[a[31:2]][7:0]   <= wd[7:0];
      
      // Byte 1 (bits 8-15)
      if (wm[1]) RAM[a[31:2]][15:8]  <= wd[15:8];
      
      // Byte 2 (bits 16-23)
      if (wm[2]) RAM[a[31:2]][23:16] <= wd[23:16];
      
      // Byte 3 (bits 24-31)
      if (wm[3]) RAM[a[31:2]][31:24] <= wd[31:24];
    end
  end
endmodule