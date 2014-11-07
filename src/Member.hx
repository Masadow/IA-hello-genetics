package ;

using StringTools;

/**
 * ...
 * @author Masadow
 */
class Member
{
    public static function random(l : Int, ascii : Bool) : Member {
        var m = new Member();
        for (i in 0...l) {
            m.string += Util.pickChar(ascii);
        }
        m.ascii = ascii;
        return m;
    }
    
    public static function crossover(left : Member, right : Member) {
        var m = new Member();
        for (i in 0...left.string.length) {
            if (Math.random() >= 0.5)
                m.string += left.string.charAt(i);
            else
                m.string += right.string.charAt(i);
        }
        m.ascii = left.ascii;
        return m;
    }
    
    public function mutate() {
        for (i in 0...Math.floor(Math.random() * string.length * 0.1) + 1) {
            var pos = Math.floor(Math.random() * string.length);
            string = string.substr(0, pos) + Util.pickChar(ascii) + string.substr(pos + 1);
        }
    }

    public var string(default, null) : String;
    public var fitness(default, null) : Int;
    
    private var ascii : Bool;

    private function new()
    {
        string = "";
        fitness = 0;
    }
    
    public function evaluate(target : String, others : Array<Member>) {
        fitness = 0;
        for (i in 0...string.length) {
            var letter = string.charAt(i);
            if (letter == target.charAt(i)) {
                //Fitness depends on rarity of the letter compared to others
                var n = -1; //Remove itself
                for (m in others) {
                    if (m.string.charAt(i) == letter)
                        n++;
                }
                //Stats of the letter
                fitness += Math.floor((1 - n / (others.length - 1)) * 9) + 1; //Gives a rarity score between 1 and 5
            }
        }
    }
    
}