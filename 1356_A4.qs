namespace Solution {

    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    operation Q1356_Q4(unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        using (q = Qubit[2]){
            unitary(q);

            let res = M(q[1]);
            if(res == One){
                ResetAll(q);
                return 0; 
            }else{ 
                ResetAll(q);
                return 1; 
            }
        }
    }
}
