using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
using System.Collections;

namespace IntroConverter
{
    class Program
    {
        enum BKColor { Red, Green, Blue, Red2, Green2, Blue2, Black } ;

        private struct ColorIndexed {
            public Color color ;
            public BKColor bkcolor ;
        }
        private struct CoordIndex {
            public int index ;
            public int x ;
            public int y ;
        }

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
        public static bool isColorEqual(Color C1, Color C2)
        {
            return (C1.R == C2.R) && (C1.G == C2.G) && (C1.B == C2.B);
        }
        private static int H2I(byte b)
        {
            if (b >= 65) return b - 65 + 10; else return b - 48;
        }

        public static Color createColorFromHTMLCode(string code)
        {
            if (code.Trim().StartsWith("#")) code = code.Trim().Substring(1, 6);

            Byte[] bytes = System.Text.Encoding.UTF8.GetBytes(code.ToUpper());

            if (bytes.Length != 6) return Color.Black;

            int r = H2I(bytes[0]) * 16 + H2I(bytes[1]);
            int g = H2I(bytes[2]) * 16 + H2I(bytes[3]);
            int b = H2I(bytes[4]) * 16 + H2I(bytes[5]);

            return Color.FromArgb(r, g, b);
        }
        static void Main(string[] args)
        {
            if (args.Length==0) {
		Console.WriteLine("Argument - PNG filename, colormap filename") ;
		return ;
	    }
            var bmp = new Bitmap(args[0]);
            var colors = new List<ColorIndexed>();
            foreach (var row in File.ReadAllLines(args[1])) 
            {
                var cols = row.Split(new char[] { '=' }) ;
                colors.Add(new ColorIndexed() {
                  color = createColorFromHTMLCode(cols[0]),
                  bkcolor = (BKColor)Int32.Parse(cols[1])
                }) ;
            }

            int WIDTH = bmp.Width;
            int HEIGHT = bmp.Height;

	    if (WIDTH % 4 !=0 ) {
		Console.WriteLine("Width must be multiple of 4") ;
		return ;
	    }
	    if (HEIGHT % 4 !=0 ) {
		Console.WriteLine("Height must be multiple of 4") ;
		return ;
	    }
            var bmpr = new Bitmap(WIDTH,HEIGHT);
            for (int j = 0; j < HEIGHT; j++)
            {
                for (int i = 0; i < WIDTH; i++)
                {
                   Color c = bmp.GetPixel(i,j) ;
                   if (c.A>0) {
                     foreach (var ci in colors) {
                        if (isColorEqual(c,ci.color)) {
                          if (ci.bkcolor==BKColor.Red) bmpr.SetPixel(i,j,Color.Red) ;
                          if (ci.bkcolor==BKColor.Green) bmpr.SetPixel(i,j,Color.Green) ;
                          if (ci.bkcolor==BKColor.Blue) bmpr.SetPixel(i,j,Color.Blue) ;
                          if (ci.bkcolor==BKColor.Red2) if ((i+j) % 2 ==0) bmpr.SetPixel(i,j,Color.Red) ;
                          if (ci.bkcolor==BKColor.Green2) if ((i+j) % 2 ==0) bmpr.SetPixel(i,j,Color.Green) ;
                          if (ci.bkcolor==BKColor.Blue2) if ((i+j) % 2 ==0) bmpr.SetPixel(i,j,Color.Blue) ;
                        }
                     }
                   }
                }
            }
            // debug save
            //bmpr.Save("bmpr.bmp") ;
            var blocks = new List<byte[]>() ;
            var indexes = new List<CoordIndex>() ;
            for (int j = 0; j < HEIGHT; j+=4)
            {
                for (int i = 0; i < WIDTH; i+=4)
                {
                   BitArray row = new BitArray(8*4);
                   row.SetAll(false);

                   for (int dy = 0; dy < 4; dy++)
                     for (int dx = 0; dx < 4; dx++) {
                        BKColor bkcolor = color2bkcolor(bmpr.GetPixel(i+dx, j+dy));
                        int p1 = dy * 8 + dx * 2;
                        int p2 = dy * 8 + dx * 2 + 1;
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

                   byte[] data = new byte[4];
                   row.CopyTo(data, 0);
                   if ((data[0]!=0)||(data[1]!=0)||(data[2]!=0)||(data[3]!=0)) {

                   int blockidx=-1 ;
                   for (int b=0; b<blocks.Count; b++)
                     if ((blocks[b][0]==data[0])&&(blocks[b][1]==data[1])&&(blocks[b][2]==data[2])&&(blocks[b][3]==data[3])) blockidx=b ;
                   if (blockidx==-1) {
                      blocks.Add(data) ;
                      blockidx=blocks.Count-1 ;
                   }
                   indexes.Add(new CoordIndex() { index = blockidx, x = i/4, y = j}) ;
                   }
                }
            }
            Console.WriteLine("; size : {0} bytes",indexes.Count*4+blocks.Count*4) ;
            Console.WriteLine("INTRO_INDEXES:") ;
            Console.WriteLine(".WORD {0}",dec2hex(indexes.Count));

            int sz = indexes.Count ;
            var rnd = new Random() ;
            for (int i=0; i<sz; i++) {
               int p = rnd.Next(indexes.Count) ;
               Console.Write(".WORD ");
               Console.Write(dec2hex(indexes[p].index));
               Console.Write(" .BYTE ");
               Console.Write(dec2hex(indexes[p].x));
               Console.Write(",");
               Console.Write(dec2hex(indexes[p].y));
               Console.WriteLine();
               indexes.RemoveAt(p) ;
            }

            Console.WriteLine("INTRO_BLOCKS:") ;
            for (int b=0; b<blocks.Count; b++) {
                   Console.Write(".BYTE ");
                   for (int r = 0; r < blocks[b].Length; r++)
                   {
                     if (r > 0) Console.Write(",");
                     Console.Write(dec2hex(blocks[b][r]));
                   }
                   Console.WriteLine();
            }

        }
    }
}
