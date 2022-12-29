namespace quantum {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation SetQubitState(result: Result, state: Qubit) : Unit {
        if(result != M(state)){
            X(state);
        }
    }
    
    @EntryPoint()
    operation SayHello(count: Int) : (Int, Int) {
        Message("Hadamard Gate");
        mutable correct = 0;
        for i in 1..count {
            use (q1) = Qubit();
            SetQubitState(Zero, q1);
            H(q1);
            let resultsQ1 = M(q1);
            if(resultsQ1 == Zero){
                let answer = Solve(Z);
                Message($"answer = {answer} when it was Z");
                if(answer == 0){
                    set correct+=1;
                }
            }else{
                let answer = Solve(S);
                Message($"answer = {answer} when it was S");
                if(answer == 1){
                    set correct+=1;
                }
            }
        }
        return (correct, count-correct);
    }

    // numerical proof that hadamard is its own inverse
    operation Proof_hadamard_is_own_inverse(): Int{
        for i in 1..1000{
            use q1 = Qubit();
            H(q1);
            H(q1);
            if(M(q1) == One){ return 0; }
        }
        return 1;
    }

    operation Solve (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
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
