using System.Text;

string text = null;
string base64 = null;

using (var sr = new StreamReader("D:\\UNIVER\\all\\IB\\Lab2\\maltese.txt", false))
{
    text = sr.ReadToEnd();
}

using (var sw = new StreamWriter("D:\\UNIVER\\all\\IB\\Lab2\\base64.txt", false))
{
    byte[] data = Encoding.UTF8.GetBytes(text);
    base64 = Convert.ToBase64String(data);

    sw.Write(base64);
}