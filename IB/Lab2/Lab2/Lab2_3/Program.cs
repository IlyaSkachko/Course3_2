using System;
using System.Text;

/*
Написать функцию, которая принимает в качестве аргументов два буфера (а и b) одинакового размера и возвращает XOR 
(собственная фамилия (а) и имя (b); при разной длине меньшую
дополнить нулями). Входные аргументы представлять: 1) в кодах
ASCII; 2) в кодах base64. Что будет результатом операции
аXORbXORb? 
При написании не использовать стандартные функции языка
программирования. Итоговые данные сравнить с результатами использования стандартных функций языка программирования (если
они есть)

*/

class Program
{
    static void Main()
    {
        string a = "Skachko";
        string b = "Ilya";

        string resultASCII = XORStringsASCII(a, b);
        string resultBase64 = XORStringsBase64(a, b);

        Console.Write("Result (ASCII): ");
        PrintASCII(resultASCII);
        Console.WriteLine();
        Console.WriteLine("Result (Base64): " + resultBase64);   
        
        Console.WriteLine();
        Console.WriteLine("Result aXORbXORb: " + XORStringsBase64(resultBase64, b));
    }

    static void PrintASCII(string str)
    {
        foreach (char c in str)
        {
            Console.Write((int)c + " ");
        }
    }

    static string XORStringsASCII(string a, string b)
    {
        int length = Math.Max(a.Length, b.Length);
        a = PadRightWithNulls(a, length);
        b = PadRightWithNulls(b, length);

        byte[] bytesA = StringToAsciiBytes(a);
        byte[] bytesB = StringToAsciiBytes(b);

        // Выполнение операции XOR между массивами
        byte[] resultBytes = new byte[length];
        for (int i = 0; i < length; i++)
        {
            resultBytes[i] = (byte)(bytesA[i] ^ bytesB[i]);
        }

        // Преобразование результата обратно в строку
        string result = AsciiBytesToString(resultBytes);

        return result;
    }

    static string XORStringsBase64(string a, string b)
    {
        // Преобразование строк в массивы байт ASCII
        byte[] bytesA = Encoding.ASCII.GetBytes(a);
        byte[] bytesB = Encoding.ASCII.GetBytes(b);

        // Выравнивание массивов байт по длине
        int length = Math.Max(bytesA.Length, bytesB.Length);
        bytesA = PadRightWithZeros(bytesA, length);
        bytesB = PadRightWithZeros(bytesB, length);

        // Выполнение операции XOR между массивами байт
        byte[] resultBytes = new byte[length];
        for (int i = 0; i < length; i++)
        {
            resultBytes[i] = (byte)(bytesA[i] ^ bytesB[i]);
        }

        // Преобразование результата обратно в строку Base64
        string resultBase64 = Convert.ToBase64String(resultBytes);

        return resultBase64;
    }

    static string PadRightWithNulls(string str, int length)
    {
        if (str.Length >= length)
            return str;

        return str.PadRight(length, '\0');
    }

    static byte[] PadRightWithZeros(byte[] bytes, int length)
    {
        if (bytes.Length >= length)
            return bytes;

        Array.Resize(ref bytes, length);
        return bytes;
    }

    static byte[] StringToAsciiBytes(string str)
    {
        byte[] bytes = new byte[str.Length];
        for (int i = 0; i < str.Length; i++)
        {
            bytes[i] = (byte)str[i];
        }
        return bytes;
    }

    static string AsciiBytesToString(byte[] bytes)
    {
        char[] chars = new char[bytes.Length];
        for (int i = 0; i < bytes.Length; i++)
        {
            chars[i] = (char)bytes[i];
        }
        return new string(chars);
    }
}