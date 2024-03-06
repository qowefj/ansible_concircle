Add-Type -AssemblyName PresentationFramework

$caption = "Windows Updates Notification"
$message = "Installation of Windows updates will start in an hour. Please save your work as the VM will be rebooted after updates."

[System.Windows.MessageBox]::Show($message, $caption, [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
