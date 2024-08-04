pragma circom 2.0.0;
include "./HelloWorld.circom";
// [assignment] Modify the circuit below to perform a multiplication of three signals

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal output d;  

   component sum = Multiplier2();
   sum.a <== a;
   sum.b <== b;

   // Constraints.  
   d <== c * sum.c;  
}

component main = Multiplier3();