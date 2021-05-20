# MonumentalAppAzureCup

* [Základní info](#Základní-info)
* [Jak zprovoznit náš projekt](#Jak-zprovoznit-náš-projekt)
* [IOS aplikace](#IOS-aplikace)
* [Využité technologie](#Využité-technologie)


## Úvod
MonumentalAppAzureCup je projekt, který jsem vyrobili jako řešení našeho tématu v rámci azure cupu. Tento projekt obsahuje IOS aplikaci, která je napojena na Azure chatbota a Cutom vision model pro rozpoznávání obrázků.

## Jak-zprovoznit-náš-projekt
Vzhledem k tomu že projekt využívá externí knihovny je nutné před jeho spuštění provést určité kroky na nahrání těchto knihoven.

Nejdříve je potřeba nainsatolat cocoapods. Pokud je již máte nainstalované můžete tento krok přeskočit. pokud ale cocoapods nainstalované nemáte nainstalujte si je podle pokynu [zde](https://www.cocoapods.org).

Nyní když máte cocoapods nainstalované otevřete terminál a vložte níže zmíněné příkazy:
```
$ cd ../<NAME OF THIS XCODE PROJECT>
$ pod install
```
Poté můžete otevřít soubor: MonumentalAppAzureCup.xcworkspace a stisknout cmd + R pro spuštění aplikace.


## Využité technologie
* aplikace
* beckend
#### ios aplikace
Nase ios aplikace je vytvořená v jazyce Swift a jeho frontendové knihovně SwiftUI. Dále jsme využili knihovnu od microsoftu MicrosoftCognitiveServicesSpeech-iOS.

#### beckend
Dan napíše....
