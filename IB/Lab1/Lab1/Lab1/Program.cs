
// Кирилица - Таджикский
// Латиница - Мальтийский


using System.Text;

class Program
{
    static void Main()
    {

        #region Task A


        string tajikText = File.ReadAllText("D:\\UNIVER\\all\\IB\\Lab1\\Lab1\\tajik.txt"); 

        double tajikEntropy = CalculateEntropy(tajikText.ToLower());
        Console.WriteLine($"Энтропия таджикского сообщения: {tajikEntropy}");

        Console.WriteLine("\n\n\n");

        string malteseText = File.ReadAllText("D:\\UNIVER\\all\\IB\\Lab1\\Lab1\\maltese.txt"); 

        double malteseEntropy = CalculateEntropy(malteseText.ToLower());
        Console.WriteLine($"Энтропия мальтийского сообщения: {malteseEntropy}");

        Console.WriteLine("\n\n");

        #endregion


        #region Task B

        string binaryFilePath = "D:\\UNIVER\\all\\IB\\Lab1\\Lab1\\binary.txt";

        string binaryText = default;

        //using (var writer = new BinaryWriter(File.Open(binaryFilePath, FileMode.OpenOrCreate)))
        //{
        //    string txt = tajikText + malteseText;
        //    writer.Write(txt);
        //}


        using (FileStream fileStream = new FileStream(binaryFilePath, FileMode.Open, FileAccess.Read, FileShare.Read))
        {
            byte[] buffer = new byte[10000];
            int bytesRead;

            while ((bytesRead = fileStream.Read(buffer, 0, buffer.Length)) > 0)
            {
                for (int i = 0; i < bytesRead; i++)
                {
                    byte currentByte = buffer[i];

                    for (int j = 7; j >= 0; j--)
                    {
                        byte bit = (byte)((currentByte >> j) & 1);
                        binaryText += bit;
                    }
                }
            }
        }

        var binaryEntropy = CalculateEntropy(binaryText);
        Console.WriteLine($"Энтропия бинарного сообщения: {binaryEntropy}");


        Console.WriteLine("\n\n");
        #endregion


        #region Task C

        string fio = "SkachkoIlyaAlexandrovich";

        Console.WriteLine($"Количество информации на основе таджикского сообщения: {tajikEntropy * fio.Length}");

        Console.WriteLine("\n\n");

        Console.WriteLine($"Количество информации на основе мальтийского сообщения: {malteseEntropy * fio.Length}");

        Console.WriteLine("\n\n");

        Console.WriteLine($"Количество информации на основе бинарного сообщения: {binaryEntropy * fio.Length * 8}");

        Console.WriteLine("\n\n");

        #endregion

        #region Task D

        double p1 = 0.1;
        double p2 = 0.5;
        double p3 = 1;


        Console.WriteLine($"Количество информации на основе таджикского сообщения(вероятность ошибки = {p1}): {AmountInfoWithError(tajikEntropy, p1, 1 - p1, fio.Length, false)}");
        Console.WriteLine($"Количество информации на основе таджикского сообщения(вероятность ошибки = {p2}): {AmountInfoWithError(tajikEntropy, p2, 1 - p2, fio.Length, false)}");
        Console.WriteLine($"Количество информации на основе таджикского сообщения(вероятность ошибки = {p3}): {AmountInfoWithError(tajikEntropy, p3, 1 - p3, fio.Length, false)}");

        Console.WriteLine("\n\n");

        Console.WriteLine($"Количество информации на основе мальтийского сообщения(вероятность ошибки = {p1}): {AmountInfoWithError(malteseEntropy, p1, 1 - p1, fio.Length, false)}");
        Console.WriteLine($"Количество информации на основе мальтийского сообщения(вероятность ошибки = {p2}): {AmountInfoWithError(malteseEntropy, p2, 1 - p2, fio.Length, false)}");
        Console.WriteLine($"Количество информации на основе мальтийского сообщения(вероятность ошибки = {p3}): {AmountInfoWithError(malteseEntropy, p3, 1 - p3, fio.Length, false)}");

        Console.WriteLine("\n\n");


        Console.WriteLine($"Количество информации на основе бинарного сообщения(вероятность ошибки = {p1}): {AmountInfoWithError(binaryEntropy, p1, 1 - p1, fio.Length * 8, true)}");
        Console.WriteLine($"Количество информации на основе бинарного сообщения(вероятность ошибки = {p2}): {AmountInfoWithError(binaryEntropy, p2, 1 - p2, fio.Length * 8, true)}");
        Console.WriteLine($"Количество информации на основе бинарного сообщения(вероятность ошибки = {p3}): {AmountInfoWithError(binaryEntropy, p3, 1 - p3, fio.Length * 8, true)}");

        #endregion
    }

    static double CalculateEntropy(string s)
    {
        Console.OutputEncoding = Encoding.UTF8;

        var charFrequencies = new Dictionary<char, int>();
        int totalCharacters = s.Length;

        foreach (char c in s)
        {
            if (char.IsLetter(c) || char.IsDigit(c))   
            {
                if (!charFrequencies.ContainsKey(c))
                    charFrequencies.Add(c, 1);
                else
                    charFrequencies[c]++;
            }
        }

        double entropy = default;
        foreach (var с in charFrequencies)
        {
            double probability = (double)с.Value / totalCharacters;
            entropy -= probability * Math.Log(probability, 2);
        }

        return entropy; 
    }

    static double AmountInfoWithError(double entropy, double p, double q, int count, bool binary)
    {
        return entropy * EffectiveEntropy(p, q, binary) * count;
    }

    static double EffectiveEntropy(double p, double q, bool binary)
    {
        if (binary && (p == 0 || q == 0))
            return 1;
        if (!binary) 
            return 0;
        return 1 - ((-p * Math.Log(p, 2)) - (q * Math.Log(q, 2)));
    }
}
