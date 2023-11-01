![alt text](https://github.com/14metehan53/bnb-chain-yarisma/blob/main/BlockchainQuestMmorpg.png?raw=true)
<br />
<code>blockchainquesttest</code> klasörü içerisinden test edebilirsiniz</p>
- npx hardhat node
- npx hardhat compile
- npx hardhat run scripts/deploy.js --network localhost
- npx hardhat test
</p>

<h4>Bsc Testnet Address</h4>
consumable : <code>0x2634713Aa3E20ff93B0083F986eF4B6D277c0bEE</code> (ERC-1155) </br>
sword      : <code>0xEA5958b0213801F224b4616Db5661BFD5B508e23</code> (ERC-721) </br>
risein     : <code>0xDDb26eC3866ed0df789b9C4DF636cFFFEB739643</code> (ERC-20)</br>
scroll     : <code>0x59E7BCECF607c4DaE8185e3fb222fc2ebfDb01A7</code> (ERC-1155)</br>
lapis      : <code>0x5B78C95C1e49116714561F28f7277b21621c0a25</code> (ERC-1155)</br>
game       : <code>0x767824A3E732a8e73d176899Cb63028E19f9b075</code> </br>
</p>

Oyun kontratı : https://testnet.bscscan.com/address/0x767824A3E732a8e73d176899Cb63028E19f9b075

<h2>Oyun Nasıl Oynanır ?</h2>
<code>startReset</code> fonksiyonuna bir kere bastıktan sonra hesabınız otomatik olarak oluşturuluyor. daha sonra <code>freeStarterPack</code> fonksiyonuna basarsanız size tanımlanan ücretsiz hediyeleri alabilirsiniz fakat <code>kılıc,str,dex,luc,rec,gold</code> game kontratında byte hatası aldığım için bazı şeyleri silmem gerekti fakat kodun silinmemiş halini readme dosyasının üzerindeki <code>BlockchainQuest.sol</code> içerisinden görebilirsiniz. Oyundaki moblar <code>Fox, Kimuraku, Opalus</code>.</p>
<span>mobları görüntülemek için mob fonksiyonun kullanabilirsiniz (id 0 : fox, id 2: kimuraku, id 3: opalus)</span>
<span>demircide kılıca lapis basarken lapis bazen kırıldığı için kodun çalışmadığını düşünebilirsiniz ama kod güzel çalışıyor bir de lapis basarken arada bir sanırsam gas yetmediği için hata veriyor ama bir iki kez denedikten sonra çalıştığını göreceksiniz</span>

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
