using System;
using System.Collections;

namespace PatternMaker
{
    class Program
    {
        static void decodeMask(string s) {
                    BitArray row = new BitArray(16);
                    row.SetAll(false);
                    for (int i=0; i<8; i++)
                      if (s[i]=='x') row.Set(1+2*i, true);
                    byte[] data = new byte[2];
                    row.CopyTo(data, 0);
                    Console.Write(Convert.ToString(data[0]*256+data[1], 8)+",");

        }
        static void Main(string[] args)
        {
             decodeMask("xxxxxxxx") ;
             decodeMask("xxxxxxxx") ;
             decodeMask("xxx xxx ") ;
             decodeMask("x xxx xx") ;
             decodeMask("xx xxx x") ;
             decodeMask(" xxx xxx") ;
             decodeMask("x x x x ") ;
             decodeMask(" x x x x") ;
             decodeMask("x x x x ") ;
             decodeMask(" x x x x") ;
             decodeMask("  x   x ") ;
             decodeMask("x   x   ") ;
             decodeMask(" x   x  ") ;
             decodeMask("   x   x") ;
        }
    }
}
