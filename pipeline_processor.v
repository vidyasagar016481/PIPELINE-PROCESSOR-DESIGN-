module pipeline_processor (
    input clk,
    input reset
);

// 4-stage pipeline: IF, ID, EX, WB
reg [31:0] PC;
reg [31:0] instruction_memory [0:31];
reg [31:0] register_file [0:15];
reg [31:0] IF_ID, ID_EX, EX_MEM, MEM_WB;

reg [31:0] alu_result;
reg [3:0] dest_reg;

// Fetch
always @(posedge clk or posedge reset) begin
    if (reset) begin
        PC <= 0;
    end else begin
        IF_ID <= instruction_memory[PC >> 2];
        PC <= PC + 4;
    end
end

// Decode
always @(posedge clk) begin
    ID_EX <= IF_ID;
end

// Execute
always @(posedge clk) begin
    case (ID_EX[31:28]) // opcode: bits 31–28
        4'b0000: begin // ADD
            alu_result <= register_file[ID_EX[23:20]] + register_file[ID_EX[19:16]];
            dest_reg <= ID_EX[27:24];
        end
        4'b0001: begin // SUB
            alu_result <= register_file[ID_EX[23:20]] - register_file[ID_EX[19:16]];
            dest_reg <= ID_EX[27:24];
        end
        4'b0010: begin // LOAD
            alu_result <= register_file[ID_EX[23:20]]; // simulate as memory address
            dest_reg <= ID_EX[27:24];
        end
    endcase
    EX_MEM <= alu_result;
end

// Write Back
always @(posedge clk) begin
    register_file[dest_reg] <= EX_MEM;
end

endmodule
