using System;
using System.IO;
using System.Collections.Generic ;
namespace BKFixAscii
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length>2) {
		Console.WriteLine("Arguments - source WIN1251 file, dest BK-0010 file") ;
		return ;
            }
            var table = new Dictionary<byte,byte>() ;
            foreach(var line in File.ReadAllLines("ascii_table")) {
               string[] tmp = line.Split(new char[] { ' ' }) ;
               table.Add((byte)(Int32.Parse(tmp[3])),(byte)Int32.Parse(tmp[0])) ;
            }
            byte[] src = File.ReadAllBytes(args[0]) ;
            for (int i=0; i<src.Length; i++) {
               if (table.ContainsKey(src[i])) src[i]=table[src[i]] ;
	    }
	    File.WriteAllBytes(args[1],src) ;
        }
    }
}
