using System;
using System.Collections.Generic ;
using System.IO ;

namespace UTF8toKOI8R
{
    class Program
    {
        static void Main(string[] args)
        {

            if (args.Length>2) {
		Console.WriteLine("Arguments - source UTF8 file, dest BK-0010 (KOI8R) file") ;
		return ;
            }

            var conv = new Dictionary<char,byte>() ;
            conv.Add('А',225) ;
            conv.Add('Б',226) ;
            conv.Add('В',247) ;
            conv.Add('Г',231) ;
            conv.Add('Д',228) ;
            conv.Add('Е',229) ;
            conv.Add('Ё',179) ;
            conv.Add('Ж',246) ;
            conv.Add('З',250) ;
            conv.Add('И',233) ;
            conv.Add('Й',234) ;
            conv.Add('К',235) ;
            conv.Add('Л',236) ;
            conv.Add('М',237) ;
            conv.Add('Н',238) ;
            conv.Add('О',239) ;
            conv.Add('П',240) ;
            conv.Add('Р',242) ;
            conv.Add('С',243) ;
            conv.Add('Т',244) ;
            conv.Add('У',245) ;
            conv.Add('Ф',230) ;
            conv.Add('Х',232) ;
            conv.Add('Ц',227) ;
            conv.Add('Ч',254) ;
            conv.Add('Ш',251) ;
            conv.Add('Щ',253) ;
            conv.Add('Ъ',255) ;
            conv.Add('Ы',249) ;
            conv.Add('Ь',248) ;
            conv.Add('Э',252) ;
            conv.Add('Ю',224) ;
            conv.Add('Я',241) ;
            conv.Add('а',193) ;
            conv.Add('б',194) ;
            conv.Add('в',215) ;
            conv.Add('г',199) ;
            conv.Add('д',196) ;
            conv.Add('е',197) ;
            conv.Add('ё',163) ;
            conv.Add('ж',214) ;
            conv.Add('з',218) ;
            conv.Add('и',201) ;
            conv.Add('й',202) ;
            conv.Add('к',203) ;
            conv.Add('л',204) ;
            conv.Add('м',205) ;
            conv.Add('н',206) ;
            conv.Add('о',207) ;
            conv.Add('п',208) ;
            conv.Add('р',210) ;
            conv.Add('с',211) ;
            conv.Add('т',212) ;
            conv.Add('у',213) ;
            conv.Add('ф',198) ;
            conv.Add('х',200) ;
            conv.Add('ц',195) ;
            conv.Add('ч',222) ;
            conv.Add('ш',219) ;
            conv.Add('щ',221) ;
            conv.Add('ъ',223) ;
            conv.Add('ы',217) ;
            conv.Add('ь',216) ;
            conv.Add('э',220) ;
            conv.Add('ю',192) ;
            conv.Add('я',209) ;

            String src = File.ReadAllText(args[0]) ;
            var res = new List<byte>() ;
            foreach(var c in src)
              if (Convert.ToInt32(c)<128) res.Add((byte)c) ; else
              if (conv.ContainsKey(c)) res.Add(conv[c]) ;
            File.WriteAllBytes(args[1],res.ToArray()) ;
        }
    }
}
