package ;

import neko.Lib;

/**
 * ...
 * @author Masadow
 */

class Main 
{
    
    public static inline var LENGTH = 100;
    public static inline var TARGET = "HelloworldIamsohappy";
    public static inline var ASCII = false; //If false, only alphabetical

    public static inline var KEEP_ELITE = 0.2; //Proportion of elites to keep each iteration
    public static inline var MUTATION_PROTECT = 0.05; //Proportion of elites to keep each iteration
    public static inline var MUTATION = 0.1; //Mutation probabilty
	
	static function main() 
	{
		var pop = new Population(LENGTH, TARGET.length, ASCII);


        pop.log = false;

        pop.evaluate(TARGET);
        

        var stop = 1000;
        while (!pop.rank(TARGET) && --stop > 0) {
            pop.show(false);
            pop.crossover(KEEP_ELITE);
            pop.mutate(KEEP_ELITE, MUTATION);
            pop.evaluate(TARGET);
        }
        pop.show(true);
	}
	
}