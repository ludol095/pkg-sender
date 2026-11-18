using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;

namespace PkgSender;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        AvaloniaXamlLoader.Load(this);
        this.Position = new PixelPoint(0, 0);
        this.Activated += (_, _) =>
        {
            this.Position = new PixelPoint(0, 0);
        };
    }
}
