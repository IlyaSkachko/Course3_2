namespace WinApp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private async void Sum_Click(object sender, EventArgs e)
        {


            var x = X.Text.Trim();
            var y = Y.Text.Trim();

            var parameters = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("X", x),
                new KeyValuePair<string, string>("Y", y)
            });

            using (var client = new HttpClient())
            {
                var response = await client.PostAsync("https://localhost:7184/sum", parameters);


                Result.Text = await response.Content.ReadAsStringAsync();
            }


        }   
    }
}