package ;

/**
 * ...
 * @author Masadow
 */
class Population
{
 
    
    private var data : Array<Member>;
    private var it : Int;
    public var log : Bool; //Enable logging

    public function new(l : Int, wl : Int, ascii : Bool) 
    {
        data = new Array<Member>();
        it = 0;
        
        for (i in 0...l) {
            data.push(Member.random(wl, ascii));
        }
    }
    
    public function evaluate(target : String) {
        for (m in data) {
            m.evaluate(target, data);
        }
    }
    
    public function show(conclude : Bool) {
        it++;
        if (log) {
            Sys.println("Iteration: "+it+"\n");
            var i = 1;
            for (m in data) {
                Sys.println("\tid : " + i++);
                Sys.println("\tname : " + m.string);
                Sys.println("\tfitness : " + m.fitness);
                Sys.println("");
            }
        }
        if (conclude)
            Sys.println("Target found in " + (it - 1) + " iterations.");
    }
    
    //Return true if the best rank is achieved (string is matched)
    public function rank(target : String) : Bool {
        data.sort(function (m1, m2) return m2.fitness - m1.fitness);
        return data[0].string == target;
    }
    
    //Generate as many child as the current pop minus selection which is the number of elites kept
    public function crossover(selectionProp : Float) {
        var selection = Math.floor(selectionProp * data.length);
        var nextGen = new Array<Member>();
        var totalWeight = 0;
        for (i in data) {
            totalWeight += i.fitness;
        }
        for (i in 0... data.length - selection) {
            var m1 : Member = null, m2 : Member = null;
            var r = totalWeight - (Math.random() * totalWeight + 1);
            for (m in data) {
                if ((r -= m.fitness) <= 0) {
                    m1 = m;
                    break ;
                }
            }
            r = totalWeight - m1.fitness - (Math.random() * (totalWeight - m1.fitness) + 1);
            for (m in data) {
                if (m != m1 && (r -= m.fitness) <= 0) {
                    m2 = m;
                    break ;
                }
            }
            if (log)
                Sys.println("\tCrossover : \n\t\t" + m1.string + "\n\t\t" + m2.string);
            var nm = Member.crossover(m1, m2);
            nextGen.push(nm);
            if (log)
                Sys.println("\t\t= " + nm.string);
        }
        //Update the new generation
        data = data.splice(0, selection).concat(nextGen);
    }
    
    public function mutate(elites : Float, prob : Float) {
        var selection = Math.floor(elites * data.length);
        for (m in data) {
            //Skip elites
            if (--selection > 0)
                continue;
            if (Math.random() < prob) {
                if (log)
                    Sys.println("\tMutation : \n\t\t" + m.string);
                m.mutate();
                if (log)
                    Sys.println("\t\t= " + m.string);
            }
        }
    }
}
