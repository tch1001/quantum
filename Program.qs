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
        mutable numZerosQ1 = 0;
        mutable numOnesQ1 = 0;
        for i in 1..count {
            use (q1) = Qubit();
            SetQubitState(One, q1);
            H(q1);
            let resultsQ1 = M(q1);
            if(resultsQ1 == Zero){
                set numZerosQ1 += 1;
            }else{
                set numOnesQ1 += 1;
            }
        }
        return (numZerosQ1, numOnesQ1);
    }

    operation Solve(unitary: (Qubit => Unit is Adj+Ctl), q1: Qubit): Int {
        unitary(q1);
        return 1;
    }
}
