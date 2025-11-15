\
Param(
  [string]$Alias = "petprogress",
  [string]$Keystore = "keystore.jks",
  [string]$ValidityDays = "36500"
)
keytool -genkey -v -keystore $Keystore -alias $Alias -keyalg RSA -keysize 2048 -validity $ValidityDays
