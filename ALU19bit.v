module ALU (
  input [18:0] A,         
  input [18:0] B,         
  input [4:0] opcode,     
  output reg [18:0] result 
);

  reg [18:0] memory [0:7]; // Memory for FFT/ENC/DEC operations

  always @(*) begin
    case (opcode)
      // Arithmetic operations
      5'b00000: result = A + B;       // Addition
      5'b00001: result = A - B;       // Subtraction
      5'b00010: result = A * B;       // Multiplication
      5'b00011: result = A / B;       // Division

      // Increment/Decrement operations
      5'b00100: result = A + 1;       // INC
      5'b00101: result = A - 1;       // DEC

      // Logical operations
      5'b00110: result = A & B;       // AND
      5'b00111: result = A | B;       // OR
      5'b01000: result = A ^ B;       // XOR
      5'b01001: result = ~A;          // NOT

      // Shift operations
      5'b01010: result = A << 1;      // Logical Shift Reft
      5'b01011: result = A >> 1;      // Logical Shift Right
      5'b01100: result = A >>> 1;     // Arithmetic Shift Right

      // Rotate operations
      5'b01101: result = {A[17:0], A[18]}; // Rotate Left
      5'b01110: result = {A[0], A[18:1]};  // Rotate Right

      // FFT operation
      5'b10001: begin
        fft(A, B);
        result = memory[0];  
      end

      // Encryption 
      5'b10010: begin
        encrypt(A, B);
        result = memory[0];  
      end

      // Decryption 
      5'b10011: begin
        decrypt(A, B);
        result = memory[0]; 
      end

      // Default 
      default: result = 19'd0;         
    endcase
  end

   // FFT operation 
  task fft;
    input [18:0] start;
    input [18:0] source;
    integer i;
    begin
      for (i = 0; i < 8; i = i + 1) begin
        memory[i] = i + source;  
      end
    end
  endtask

  // Encryption task 
  task encrypt;
    input [18:0] start;
    input [18:0] source;
    reg [18:0] key;
    integer i;
    begin
      key = 19'b1010101010101010101;  
      for (i = 0; i < 8; i = i + 1) begin
        memory[i] = source + i; 
        memory[i] = memory[i] ^ key; 
      end
    end
  endtask

  // Decryption task 
  task decrypt;
    input [18:0] start;
    input [18:0] source;
    reg [18:0] key;
    integer i;
    begin
      key = 19'b1010101010101010101;  
      for (i = 0; i < 8; i = i + 1) begin
        memory[i] = source + i; 
        memory[i] = memory[i] ^ key; 
      end
    end
  endtask

endmodule