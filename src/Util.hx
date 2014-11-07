package ;

/**
 * ...
 * @author Masadow
 */
class Util
{

    public static function pickChar(ascii : Bool) {
        var c = !ascii ? String.fromCharCode(Math.floor(Math.random() * 25) + 65) : String.fromCharCode(Math.floor(Math.random() * 94) + 32);
        if (!ascii && Math.random() > 0.5)
            c = c.toLowerCase();
        return c;
    }
    
}