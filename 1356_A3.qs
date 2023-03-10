namespace Solution {
 
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    operation Q1356_Q3(unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using (q1 = Qubit()){
            H(q1);
            unitary(q1);
            unitary(q1); // either I or Z
            H(q1);

            let res = M(q1);
            if(res == Zero){ return 0; }
            else{ 
                X(q1);
                return 1; 
            }
        }
    }
}