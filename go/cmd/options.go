package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	// url_launcher "github.com/go-flutter-desktop/plugins/url_launcher"
	file_picker "github.com/miguelpruivo/flutter_file_picker/go"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(800, 1280),
	flutter.AddPlugin(&file_picker.FilePickerPlugin{}),
	//flutter.AddPlugin(&url_launcher.UrlLauncherPlugin{}),
}
