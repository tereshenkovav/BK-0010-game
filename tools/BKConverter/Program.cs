using System;
using System.Drawing;
using System.Collections;

namespace BKConverter
{
    class Program
    {
        enum BKColor { Red, Green, Blue, Black } ;

        static string dec2hex(int v)
        {
            return Convert.ToString(v, 8);
        }
        static BKColor color2bkcolor(Color c) 
        {
               if ((c.R > c.G) && (c.R > c.B)) return BKColor.Red ;
               if ((c.G > c.R) && (c.G > c.B)) return BKColor.Green ;
               if ((c.B > c.R) && (c.B > c.G)) return BKColor.Blue ;
                return BKColor.Black ;
        }
        static void Main(string[] args)
        {
            if (args.Length==0) {
		Console.WriteLine("Argument - PNG filename, forced color [R,G or B] optional") ;
		return ;
	    }
            var bmp = new Bitmap(args[0]);

            BKColor forcedcolor = BKColor.Black ;
            if (args.Length>1) {
                if (args[1]=="R") forcedcolor = BKColor.Red ;
                if (args[1]=="G") forcedcolor = BKColor.Green ;
                if (args[1]=="B") forcedcolor = BKColor.Blue ;
            }
            int WIDTH = bmp.Width;
            int HEIGHT = bmp.Height;

	    if (WIDTH % 4 !=0 ) {
		Console.WriteLine("Width must be multiple of 4") ;
		return ;
	    }
            for (int r = 0; r<2; r++) { 
                if (r==0) 
                	Console.WriteLine("; normal sprite") ;
		else
                	Console.WriteLine("; mirror sprite") ;
                Console.WriteLine(".WORD {0}", dec2hex(WIDTH/4));
                Console.WriteLine(".WORD {0}", dec2hex(HEIGHT));
                for (int j = 0; j < HEIGHT; j++)
                {
                    BitArray row = new BitArray(WIDTH * 2);
                    row.SetAll(false);
                    for (int i = 0; i < WIDTH; i++)
                    {
                        int p1 = (r == 0) ? (i * 2) : (WIDTH * 2 - 2 * i- 2);
                        int p2 = (r == 0) ? (i * 2 + 1) : (WIDTH * 2 - 2 * i - 1);
                        BKColor bkcolor = color2bkcolor(bmp.GetPixel(i, j));
                        if ((forcedcolor!=BKColor.Black)&&(bkcolor!=BKColor.Black)) bkcolor = forcedcolor ;
                        if (bkcolor==BKColor.Red)
                        {
                            row.Set(p1, true);
                            row.Set(p2, true);
                        }
                        else
                        if (bkcolor==BKColor.Blue)
                        {
                            row.Set(p1, true);
                            row.Set(p2, false);
                        }
                        else
                        if (bkcolor==BKColor.Green)
                        {
                            row.Set(p1, false);
                            row.Set(p2, true);
                        }
                    }
                    byte[] data = new byte[WIDTH / 4];
                    row.CopyTo(data, 0);
                    Console.Write(".BYTE ");
                    for (int i = 0; i < data.Length; i++)
                    {
                        if (i > 0) Console.Write(",");
                        Console.Write(dec2hex(data[i]));
                    }
                    Console.WriteLine();
                }
            }
        }
    }
}
