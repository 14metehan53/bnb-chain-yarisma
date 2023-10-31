![alt text](https://github.com/14metehan53/bnb-chain-yarisma/blob/main/BlockchainQuestMmorpg.png?raw=true)
<br />
<code>blockchainquesttest</code> klasörü içerisinden test edebilirsiniz</p>
- npx hardhat node
- npx hardhat compile
- npx hardhat run scripts/deploy.js --network localhost
- npx hardhat test
</p>

<h4>Bsc Testnet Address</h4>
consumable : <code>0x07C1a7EdE927Ad3EcFfDcCef1024eF67d056CD0F</code> </br>
sword      : <code>0xaE5d52d6fC0DF7F670B37Be02B9d390991Ab0a19</code> </br>
risein     : <code>0xCb7c33FB0bFB77C1a40efE689202770052680F69</code> </br>
scroll     : <code>0xcCEf731936F7F82c36289067b7D17e0b5ade880D</code> </br>
lapis      : <code>0xD359BeF2E13C55892AED1d3d00B815564F808D5F</code> </br>
game       : <code>0xcfE55aB6F8aACCFFC2e15fcb24d548511D4D6ff5</code> </br>
</p>

<h2>Oyun Nasıl Oynanır ?</h2>
<code>startReset</code> fonksiyonuna bir kere bastıktan sonra hesabınız otomatik olarak oluşturuluyor. daha sonra <code>freeStarterPack</code> fonksiyonuna basarsanız size tanımlanan ücretsiz hediyeleri alabilirsiniz fakat <code>kılıç,str,dex,gold</code> hediyelerini alabilirsiniz 2 tane lapis çıkartmamın sebebi game kontratında byte hatası aldığım için bazı şeyleri silmem gerekti fakat kodun silinmemiş halini readme dosyasının üzerindeki <code>BlockchainQuest.sol</code> içerisinden görebilirsiniz. Oyundaki moblar <code>Fox, Kimuraku, Opalus</code>.</p>
<span>mobları görüntülemek için mob fonksiyonun kullanabilirsiniz (id 0 : fox, id 2: kimuraku, id 3: opalus)</span>

<h2>Drop Listesi</h2>
<code>Fox</code> <span></span> Mobu kestiğiniz zaman otomatik olarak gold ve <code>0 - 30</code> arasında random atak statlı kılıç düşürüyor
</p>
<code>Kimuraku</code> <span>Oyundaki mini boss sayılabilir bunu keserseniz yine gold ve random(str - dex - luc - rec) lapis alırsınız.</span>
</p>
<code>Opalus</code> <span>Oyundaki en güçlü Boss. Eğer bunu keserseniz yine gold ve parşomen düşürürsünüz.</span>

<h2>Itemler ne işe yarar ?</h2>
<code>Lapis</code> <span>Lapisler kılıcınzın atak gücünü arttırmaya yarar. <code>Str +20, Dex +15, Luc +10, Rec +5</code> atak gücü arttırır.</span>
</p>
<code>Safety Scroll(parşomen)</code> <span>bu oyundaki en değerli itemlerden bir tanesi çünkü kılıcınıza hem <code>Enchant hem demirci</code> de lapis basarken çok işinize yarar. Fakat Lapis basarken lapis %40 oranında yanma ihtimali var fakat kılıcınız asla yanmaz sadece enchant basarken yanar!</span>
</p>
<code>Pot</code> <span>Oyunda 3 farklı pot çeşidi bulunmakta <code>smallPotion, middlePotion, bigPotion</code>. smallPotion 50 golda satın alabilirsiniz canınızı 50 arttırır. middlePotion 150 golda alabilirsiniz canınızı 100 arttırır. bigpotion 400 gold alabilirsiniz canınızı 200 arttırır. Fakat oyunda set mantığı yapmadığım için small veya middle pot alabilirsiniz.</span>
</br>

<h3>Not</h3>
Oyunumdan bazı kodları kaldırdığım için bazı şeyler tam istediğim gibi olmadı normalde çok fazla kod yazmıştım her şey tam istediğim gibiydi fakat byte hatası yüzünden çoğu kodu kaldırmak zorunda kaldım :(
