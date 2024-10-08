// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2019 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

`define stop $stop
`define checkh(gotv,expv) do if ((gotv) !== (expv)) begin $write("%%Error: %s:%0d:  got='h%x exp='h%x\n", `__FILE__,`__LINE__, (gotv), (expv)); `stop; end while(0);
`define checks(gotv,expv) do if ((gotv) != (expv)) begin $write("%%Error: %s:%0d:  got='%s' exp='%s'\n", `__FILE__,`__LINE__, (gotv), (expv)); `stop; end while(0);

module t (/*AUTOARG*/
   // Inputs
   clk
   );
   input clk;

   integer cyc = 0;

   int     imap[int];

   // associative array of an associative array
   logic [31:0] a [logic [31:0]][logic [63:0]];

   task static disp();
      int i = 60;
      imap[i++] = 600;
      imap[i++] = 601;
      foreach (imap[k]) $display("imap[%0d] = %0d", k, imap[k]);
   endtask

   always @ (posedge clk) begin
      cyc <= cyc + 1;
      if (cyc == 1) begin
         a[5][8] = 8;
         a[5][9] = 9;
         imap[10] = 100;
         imap[11] = 101;
      end
      else if (cyc == 2) begin
         `checkh(a[5][8], 8);
         `checkh(a[5][9], 9);
         disp();
         $write("*-* All Finished *-*\n");
         $finish;
      end
   end

endmodule
