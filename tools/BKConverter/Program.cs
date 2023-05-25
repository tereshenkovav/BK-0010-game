using System;
using System.Drawing;
using System.Collections;

namespace BKConverter
{
    class Program
    {
        static string dec2hex(int v)
        {
            return Convert.ToString(v, 8);
        }
        static void Main(string[] args)
        {
            var bmp = new Bitmap("unicorn.png");

            int WIDTH = 32;
            int HEIGHT = 32;
            for (int r = 0; r<2; r++) { 
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
                        Color c = bmp.GetPixel(i, j);
                        if (c.R == 255)
                        {
                            row.Set(p1, true);
                            row.Set(p2, true);
                        }
                        else
                        if (c.G == 255)
                        {
                            row.Set(p1, true);
                            row.Set(p2, false);
                        }
                        else
                        if (c.B == 255)
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
