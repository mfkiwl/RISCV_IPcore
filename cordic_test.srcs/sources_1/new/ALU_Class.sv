`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2021 22:29:46
// Design Name: 
// Module Name: ALU_Class
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

import Architecture_AClass::*;

`define OPERATION_ENUM_VEC_BITWIDTH 32
`define ALU_INTERNALS_INITIAL_STATE 'h0000_0000
`define aluvector(dtype) dtype [`REGISTER_GLOBAL_BITWIDTH : 0] // Extra bit for overflow indication

package ALU_Class;
    typedef enum logic[`OPERATION_ENUM_VEC_BITWIDTH - 1 : 0]
                        {  ALU_ADD = 1,
                           ALU_SUB = 2,
                           ALU_XOR = 3,
                           ALU_AND = 4,
                           ALU_NOR = 5,
                           ALU_OR = 6,
                           ALU_SLT = 7,
                           ALU_NAND = 8 } OperationType;
                                    
    class ALU extends Architecture_AClass::Architecture;
        local `rvector left_operand;
        local `rvector right_operand;
        local `aluvector(`rvtype) outcome;
        
        
        function new();
            this.left_operand = `ALU_INTERNALS_INITIAL_STATE;
            this.right_operand = `ALU_INTERNALS_INITIAL_STATE;
            this.outcome = `ALU_INTERNALS_INITIAL_STATE;
        endfunction
        
        function `rvector PerformOperation(input OperationType operation);
            unique case(operation)
                1: this.outcome = this.left_operand + this.right_operand;
                2: this.outcome = this.left_operand - this.right_operand;
                3: this.outcome = this.left_operand ^ this.right_operand;
                4: this.outcome = this.left_operand & this.right_operand;
                5: this.outcome = ~(this.left_operand | this.right_operand); // TODO: Check if it doesn't cause overflow here!!!
                6: this.outcome = this.left_operand | this.right_operand;
                7: this.outcome = this.left_operand < this.right_operand ? `static_cast_to_regvector(1) : `static_cast_to_regvector(0);
                8: this.outcome = ~(this.left_operand & this.right_operand);
                default: ; // Do nothing
            endcase
        
        endfunction
    
    endclass
endpackage
