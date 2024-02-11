namespace WinApp
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            X = new TextBox();
            Y = new TextBox();
            Result = new TextBox();
            Sum = new Button();
            SuspendLayout();
            // 
            // X
            // 
            X.Location = new Point(258, 74);
            X.Name = "X";
            X.Size = new Size(238, 23);
            X.TabIndex = 0;
            // 
            // Y
            // 
            Y.Location = new Point(258, 147);
            Y.Name = "Y";
            Y.Size = new Size(238, 23);
            Y.TabIndex = 1;
            // 
            // Result
            // 
            Result.Location = new Point(258, 284);
            Result.Name = "Result";
            Result.Size = new Size(238, 23);
            Result.TabIndex = 2;
            // 
            // Sum
            // 
            Sum.Location = new Point(324, 206);
            Sum.Name = "Sum";
            Sum.Size = new Size(99, 41);
            Sum.TabIndex = 3;
            Sum.Text = "Sum";
            Sum.UseVisualStyleBackColor = true;
            Sum.Click += Sum_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(Sum);
            Controls.Add(Result);
            Controls.Add(Y);
            Controls.Add(X);
            Name = "Form1";
            Text = "Form1";
            Load += Form1_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private TextBox X;
        private TextBox Y;
        private TextBox Result;
        private Button Sum;
    }
}