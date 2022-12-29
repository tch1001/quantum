namespace Solution {

    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    operation ItensorX(q: Qubit[]): Unit is Adj+Ctl {
        I(q[0]);
        X(q[1]);
    }
    operation CNOT_wrapper(q: Qubit[]): Unit is Adj+Ctl {
        CNOT(q[0], q[1]);
    }
    
    @EntryPoint()
    operation SayHello(count: Int) : (Int, Int) {
        mutable correct = 0;
        for i in 1..count {
            using (q1 = Qubit()){
                H(q1);
                let resultsQ1 = M(q1);
                if(resultsQ1 == Zero){
                    let answer = Solve(ItensorX);
                    Message($"answer = {answer} when it was I tensor X");
                    if(answer == 0){
                        set correct+=1;
                    }
                }else{
                    let answer = Solve(CNOT_wrapper);
                    Message($"answer = {answer} when it was CNOT");
                    if(answer == 1){
                        set correct+=1;
                    }
                }
                Reset(q1);
            }
        }
        return (correct, count-correct);
    }

    operation SetQubitState(result: Result, state: Qubit) : Unit {
        if(result != M(state)){
            X(state);
        }
    }
    operation Solve (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
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
