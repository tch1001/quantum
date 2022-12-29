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
                let answer = Solve(I);
                Message($"answer = {answer} when it was I");
                if(answer == 0){
                    set correct+=1;
                }
            }else{
                let answer = Solve(X);
                Message($"answer = {answer} when it was X");
                if(answer == 1){
                    set correct+=1;
                }
            }
        }
        return (correct, count-correct);
    }

    operation Solve (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using (q1 = Qubit()){
            unitary(q1);
            let res = M(q1);
            if(res == Zero){ return 0; }
            else{ 
                X(q1);
                return 1; 
            }
        }
    }
}
