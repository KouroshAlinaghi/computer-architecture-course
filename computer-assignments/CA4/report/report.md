# Computer Architecture - Computer Assignment 4
## RISC-V Pipeline Implementation

| Full Name | Student ID |
| ----- | - |
| Arshia Motaghian | 810101503 |
| Kourosh Alinaghi | 810101476 |

### Datapath Design
[![image.png](https://i.postimg.cc/t4xXbt60/image.png)](https://postimg.cc/gxG9qh44)

### Controller Design (Combinational)

| `op` | `f3` | `f7` | `ResultSrcD` | `MemWriteD` | `ALUSrcD` | `ImmSrcD` | `RegWriteD` | `ALUOp` | `LUIInstr` | `JumpD` | `BranchD` |
| - | - | - | - | - | - | - | - | - | - | - | - |
| Load Word | _ | _ | `2'b01` | `1'b0` | `1'b0` | `I_TYPE_ImmSrc` | `1'b1` | `2'b00` | `1'b1` | `2'b00` | `3'b000` |
| I-Type | _ | _ | `2'b00` | `1'b0` | `1'b1` | `I_TYPE_ImmSrc` | `1'b1` | `2'b10` | `1'b0` | `2'b00` | `3'b000` |
| S-Type | _ | _ | `2'b00` | `1'b1` | `1'b1` | `S_TYPE_ImmSrc` | `1'b0` | `2'b00` | `1'b0` | `2'b00` | `3'b000` |
| B-Type | `BEQ` | _ | `2'b00` | `1'b1` | `1'b0` | `B_TYPE_ImmSrc` | `1'b0` | `2'b01` | `1'b0` | `2'b00` | `branchEq` |
| B-Type | `BNE` | _ | `2'b00` | `1'b1` | `1'b0` | `B_TYPE_ImmSrc` | `1'b0` | `2'b01` | `1'b0` | `2'b00` | `branchNEq` |
| B-Type | `BLT` | _ | `2'b00` | `1'b1` | `1'b0` | `B_TYPE_ImmSrc` | `1'b0` | `2'b01` | `1'b0` | `2'b00` | `branchLEq` |
| B-Type | `BGE` | _ | `2'b00` | `1'b1` | `1'b0` | `B_TYPE_ImmSrc` | `1'b0` | `2'b01` | `1'b0` | `2'b00` | `branchGEq` |
| R-Type | _ | _ | `2'b00` | `1'b0` | `1'b0` | _ | `1'b1` | `2'b10` | `1'b0` | `2'b00` | `3'b000` |
| U-Type | _ | _ | `2'b11` | `1'b0` | `1'b0` | `U_TYPE_ImmSrc` | `1'b1` | `2'b00` | `1'b1` | `2'b00` | `3'b000` |
| JALR | _ | _ | `2'b10` | `1'b0` | `1'b1` | `I_TYPE_ImmSrc` | `1'b1` | `2'b00` | `1'b0` | `jumpRegister` | `notBranch` |
| JAL | _ | _ | `2'b10` | `1'b0` | `1'b1` | `J_TYPE_ImmSrc` | `1'b1` | `2'b00` | `1'b0` | `jump` | `notBranch` |

### `ALUControl`

| `ALUOp` | `op` | `f3` | `f7` | `ALUControl` |
| ------- | ---- | ---- | ---- | ------------ |
| `2'b00` | _    | _    | _    | `ALU_ADD`    |
| `2'b01` | _    | _    | _    | `ALU_SUB`    |
| `2'b10` | I-Type | `ADDI_F3` | _    | `ALU_ADD` |
| `2'b10` | _ | `ADD_F3` | `ADD_F7` | `ALU_ADD` |
| `2'b10` | _ | `SUB_F3` | `SUB_F7` | `ALU_SUB` |
| `2'b10` | _ | `XOR_F3` | _ | `ALU_XOR` |
| `2'b10` | _ | `AND_F3` | _ | `ALU_AND` |
| `2'b10` | _ | `OR_F3` | _ | `ALU_OR` |
| `2'b10` | _ | `SLT_F3` | _ | `ALU_SLT` |
| `2'b10` | _ | `SLTU_F3` | _ | `ALU_SLTU` |

### `PCSrcE`

| `BranchE` | `ZeroE` | `ResSignE` | `jumpE` | `PCSrcE` |
| --------- | ------- | ---------- | ------- | -------- |
| `branchEq` | `1'b1` | _          | _       | `2'b01`  |
| `branchNEq`| `1'b0` | _          | _       | `2'b01`  |
| `branchLEq`| _      | `1'b1`     | _       | `2'b01`  |
| `branchGEq`| _      | `1'b0`     | _       | `2'b01`  |
| `notBranch`| _      | _          | `jump`  | `2'b01`  |
| `notBranch`| _      | _          | `jumpRegister` | `2'b10`  |
| _          | _      | _          | _       | `2'b00`  |