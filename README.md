# MonumentalAppAzureCup

* [Základní info](#Základní-info)
* [Jak zprovoznit náš projekt](#Jak-zprovoznit-náš-projekt)
* [IOS aplikace](#IOS-aplikace)
* [Využité technologie](#Využité-technologie)


## Úvod
MonumentalAppAzureCup je projekt, který jsem vyrobili jako řešení našeho tématu v rámci azure cupu. Tento projekt obsahuje IOS aplikaci, která je napojena na Azure chatbota a Cutom vision model pro rozpoznávání obrázků.

## Jak-zprovoznit-náš-projekt
Sežeňte si zařízení s nainstalovanou nejnovější verzí xcode.

Vzhledem k tomu že projekt využívá externí knihovny je nutné před jeho spuštění provést určité kroky na nahrání těchto knihoven.

Nejdříve je potřeba nainsatolat cocoapods. Pokud je již máte nainstalované můžete tento krok přeskočit. pokud ale cocoapods nainstalované nemáte nainstalujte si je podle pokynu [zde](https://www.cocoapods.org).

Nyní když máte cocoapods nainstalované otevřete terminál a vložte níže zmíněné příkazy:
```
$ cd ../<NAME OF THIS XCODE PROJECT>
$ pod install
```
Poté můžete otevřít soubor: MonumentalAppAzureCup.xcworkspace zvolte target na kterém chcete aplikaci spustit (simulátor nebo fyzické zařízení) a stisknout cmd + R pro spuštění aplikace.

Pokud vám ani těď nejde aplikace spustit v simulatoru nebo na fyzickém zařízení máte nejspíš jeden z těchto problémů:
* [Zastaralá verze swiftu](#Zastaralá_verze_swiftu)
* [simulátor na m1 macu](#Simulátor_M1)

#### Zastaralá verze swiftu
Aplikace je napsaná ve verzi swiftu 5.3.2 tudíž na starších verzích nefunguje.
To zda li máte tento problém můžete zjistit pomocí comandu v terminálu:
```
$ swift --version
```
Pokud nemáte verzi 5.3.2 tak si ho aktualizujte.

#### Simulátor M1
Vzhledem k tomu že naše aplikace využívá microsoft knihovnu která nepodporuje ARM architekturu nejde tato aplikace/projekt spustit na simulátoru M1 maců. Na fyzickém zařízení to ale funguje normálně tudíž doporučuji to.

## Využité technologie
* aplikace
* backend
#### ios aplikace
Naše ios aplikace je vytvořená v jazyce Swift a jeho frontendové knihovně SwiftUI. Dále jsme využili knihovnu od microsoftu MicrosoftCognitiveServicesSpeech-iOS.

#### backend
 Co se týče backendu tak ten je celý v Azure. <br>
 Využili jsme 3 jeho služby: 
 * speech to text - cognitive services speech
 * Chatbot - QnA maker
 * AI image classification - Custom vision


