Return-Path: <linux-wireless+bounces-21443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800A2A85B57
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DD43BF1B0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909E1DE3C7;
	Fri, 11 Apr 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="mjaVuw6d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE17278E7D;
	Fri, 11 Apr 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369822; cv=none; b=pkyDmTBVarQC8xkoNSNBxKGnCbaavthX4dZ4hEZRxRGislc28FEoEK2C+pqr2/LzaqgOtMjfcOz7bSEZyhli99373IblKKs7yl9GHMuac1OG056YGCSoQ7RgXTuAre3z+a+E4HGd23N0jDnPJBZkhRgbnylhkKdiSnACJB2EPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369822; c=relaxed/simple;
	bh=YcRXvpJ3ie5nG7EQJ4C9ib3thsK6sc4G5X3WceaVQ5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKGxoYKyHUn3x5j+89q/ZZdCZPqK7ylHu7bNyQSGa0TmPJZe2T4OklyalsXP+MzYTuuMQ/e9Pfn9L4ngjPYOtWZq6zoM82McGziz73vyfPsP0znVD+hC+jvGIcy+myNt32mpZsinPvU5Ld5ij2iaSJkgWcOpCf/ygRBEX2uNVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=mjaVuw6d; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744369803; x=1744974603; i=spasswolf@web.de;
	bh=nC8/HoNmbsjP2dbmmx5moQUyLcOmf6JQ+1k6aS/Crl0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mjaVuw6dFUf1f1fbgPYE2FaznSupVY0tjgHfXCAGzip7kf6x6EhM+/vvzl0MY2hW
	 0QvtzblsDmGeGFrrK/1hRAvHHYlyrISrtnFUVcpUIbeSPa/TZ9ApSPyu4z12VREUF
	 YX9TgHKm4IWQmkKi5XP8WTPDuB6P8tVhhnuVVxXQ8/tgoU0RhOsmrYFw7gs1cjPCa
	 fbmfwDA4pVGu11qnU0QZnw8mX3186sWcbRjffjpW50ZKSO9Rw/55QGsL6DCwuaTg2
	 qZbfUJrVwY44wKkaLVmEj2Gv0EUVP9Thy+6in3V7la+j7fhtRWJJnJIUz3WwygWPw
	 PFKG1h3lc8l1wjcapA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmm4-1trbQr16wQ-00BdBo; Fri, 11
 Apr 2025 13:10:03 +0200
Message-ID: <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
From: Bert Karwatzki <spasswolf@web.de>
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	johannes@sipsolutions.net, linux-mediatek@lists.infradead.org,
 spasswolf@web.de
Date: Fri, 11 Apr 2025 13:10:02 +0200
In-Reply-To: <Z_jpq26P99qzPP1c@pilgrim>
References: 
	<06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
	 <20250410215527.3001-1-spasswolf@web.de> <Z_jpq26P99qzPP1c@pilgrim>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MBviC8whEiPJe7pmM0jVezi9C3/XRuMkOif/rqtPw7K9atKM+f9
 kaIDnc1ErMlLuO96QOFul0MVhNaPPhqnYZFdkPX8EzCyHzmli/OM5O3bd9TwvsiUPGo70zT
 xI6+DNBODpvn6sJ8rOz21v8kdUGkoFgMBm+tHLb3BXszzLL0yIp/8ZhuCEez602g71g2sX6
 YAtbE7rI2aokODHpTdwfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DbtQvAkBNvc=;xwOCkkx/GFgx6R6HES7wyc6BD2s
 /hQzIqU/m5TsgBwHStRAx2plbgqB5VyYt1/bD9JCUAsQH/aK9V1CeRURGDDQemQpDR7FLTsga
 Dv/pw3D/EGzPFOLZgyUxOx596otVH1ZlTD9Vp951GZ1M6E0PYOwRwxsP5Coiin+XAHNlfaW6s
 BQKoEcanXW3+52M7j4+qnOTBihHIOZIRbuHkFOfvj907K6V5CvlMfaLEa95zouIUyLiSRAD+b
 PjlE2fuE+uiTncx20JuklAkN9kARKaouK8xGxE0tl2Q8Fnseq6fhAZSGTpBq+pwRztuuI+ulC
 qO9Bark4qULfXuMyIVFRIG7eUYedsbk8pOAPya/qC0VDINCpsfO8ASfOhluLWPmzI2hNY1Bzd
 jiagNtSJ0Vouw50Twf6dc1fLFH2lSZqvdfGboLKjLz1N5iX3331GberFcBBel89bFMVPzCy/F
 ljnTEHZWmXqe9nwdySnnVfQoqgHd/+1H2M8zdHQsQaYjKKkiSh/xqwn8QEbgm8gd/QwxAYIMv
 GVPi7Sl7v14AcLgr930j+o8pqSPrAh8986bIa9HtsN9XO04jDGyWmnibzE7e2BiwHuUJcLceI
 TQJeC9lCUt1OELw1zAMp3K04t0d3Ob5Mdj2Qadd+Ocur2d56+gPGRptV0pD1adxVYOLsduXsV
 turxsCfV6HBQjgPKtqPjiB2kCSMJFFZgUYV2MLfR5NsMHn+VoQcuka75si6eGxvWS84WWw5RP
 3kLKjB1la/TnKwO19pX3D9Qv7hHosKUTl9DdYg/VQ/IQQ0gRflLl6d9ZlakZmCimH+PA2+pyl
 ctk5gR74zDIyw3FtJ6PTUKLkyQwqWmgtixQaJJzgYZX5oINoiLUEw44oao+iciNxmMdsmSd9p
 Nw41YMo/ZfyLk6o07wyptWUVnDrrPVVX1tuTZ6wG4vlwYaRJOAQhYHnT6Ay871BPQzLW35KUg
 CPS0NmeBvRZqgtO5ymT+FqCO4y2w14f1R7fTsDjYlqhE2yhIsJyzN4ohu+TN9AO66TGZEifH2
 Ai61gBnAumSqmy51PKuwa9o9BPam4ONHQopoB/rKm5SIr+yuoHkuMSXmboc53kQ7wcXGJdJLu
 J1j3aeXeMr54jZIJwaouG81GQswuaeMITm5kDLx8jD5/JvMohIHsr9Gcz6j5dqvC+T6xtjPiL
 LvHIW/MyMOhN7sETUvgahhrFC1oJ/Ep7RQZnVYrhf5zQv/eAqLUHbOWW4AWf69IfTvqo/+PYF
 hJAowUgEvmZrPfqK7euhtHGCouCCeyHYB1aezk2cIjTrPbX1s+IsxsxDYGCkf/YZfM79WEM+u
 2JEYQfYWlAwTpAA4ODNsbROG4xDGznKfcVDpm9HhcU2dt3OSZsqL775WDONFpvSjIW45h7r7Z
 Tus5wZ3MOycfZMtobGfUdKLTm+/CP6ffAs4N+J6Zp5kFRkr73ebZoXreYdMB1QmBe+KeTX6kc
 lXEWis+Gm+wGjEPtMqKb4OGKznNnXTNINf/mKwLQrg+4+nwv9xWDZHgZXIEuh80Kir+kW3oNa
 xihhnugO5UzTEZbowY6AFJzg3m/OK4YsPSt+1kY12jnep2IVmTrjwRYC8MimJzLYNLldZ/+lp
 Gkv1kcr+ABlx+a51txtCAmEedLLcBLQJKmjUWLhrw4bsR1CzzXk1I4KwmRbdARilccglQL3+E
 0ijV2QwbMWbaPxx88R/WdH4y6ankKWLqsmo/PkgwPIhZbO/T/v7bMSGS++JJlk9psflCqWYOs
 PaGHLI4KBObtAn0s5ioauiy7TgYLPp+mBvcEkeKaau+YBnviTs5Q1zjv4BEj2oo8H1k0yC/J8
 1T3zKcFTnup3XC7ie5dFYopZ7O/cmLlD14JYryzGe5gKD0pRJI5CVnsBFXCB/I0jGO8wjVPKr
 VaJlWhZe/sLv3zb93GQfi8A644l6Hq68kGEOper7FyC6Pd3RBKvodAXKWEKlFQzkrPpKTGI57
 Xe/aCGN/hoAqXcbECHTzLUk6roFRex+CGMC6uQiGHPXQg9sLsB5Sgz/qkkfWZGK+tlZqvMjFC
 SaJa3Kv777HyNao8acCLdCGNny06UCnj1AsUs9+Cc7mPeRirnXfG4QKLT3Zcjm8zTSmUApsKc
 gBJXFkRR5lRcXaMtouFAOgfMfY4F1AOtf53gzXs5618eCwsYp2+7ii+kk8FhySx97oFtksARm
 RfbvQOBRE9S0KaJ+JVWpYRripqjfnPFgTuK2rKUJW1L0nd9q1MfPH4fL6FlntC2Gx3Xm84TLy
 seEEfySvKQyuCoVZw9WTZbOKevfY4tVAE4GFnKoM7eJP2Ryvqc0x1GqAc98WMTJaK5UgRms/C
 hKRRUf4YlI/0VK8tTGoC6wi6cEJNUI8UJXXAzchAQ8XoXR7v59QdHL5kmkoyy/beDRTNd4uaL
 cze5iZyz4Dpjnk/F7F1kw4UkQiFiGolqQk7sZI7zNgLgzlqyEFyQ0MFUNJbcXaTd/fleyqjRN
 mQj08ja9LskVdenEoDoeyFO3EKniqcDvkZiDUqrPZ282qhs+SOEApJz3qqyDx4IWAKtA0m+U0
 0hkdz+YbIrBs/Dspm2TNTuQgg6xPamGRze3mJDt8i4wK3E9AMrolCFPWnXug57m7QZ2Wp9sNJ
 YNoX8nbEZocKfyxOY514P4xjpti0sDOrB2vTKGQ8osexKvOxb6ywlr37iyvqQA4LnwjEi8UPY
 h//fzouW1QsVvKY7AQGFnio8hGzFe70cuw8CucPr3B6ZJQf2b2gO6tvIeWRtNkI4TKxt+gyCG
 F0e+PRsROEN5ehGSzHNq3AnQIYuBGnRkTkgSdqD/3Yp+vXFeHsydfj6G6wk9ebMad8/z4M3nm
 ba4kIpyrU7Af0ETM1r5AqUhzQHMFenl4dEB/ZfqM04ghaRNNO3XVwi2ww8hQJ/gvGkAadbFyk
 oGDhY2Nc/jyCSR9/QGydDEO3hJYRjSbeKpRPJ2lu8Pmu+r96pWRLLSJdQtIIOJbymwneo+9v1
 n7jAtYZrkKRwIc0p/DtUpKtwD7RYGbmP6LXQJ4nZQXzeW9hkXfHcVHjdLN8tKP6vA5CeuXnP3
 Q==

Am Freitag, dem 11.04.2025 um 12:06 +0200 schrieb Remi Pommarel:
> Hi Bert,
>
> On Thu, Apr 10, 2025 at 11:55:26PM +0200, Bert Karwatzki wrote:
> > This commit breaks the mediatek mt7921 wireless driver. In linux-next-=
20250410
> > my mt7921e Wi-Fi controller is no longer able to connect to a network.
> > I bisected this to commit a104042e2bf6 ("wifi: mac80211: Update skb's =
control
> > block key in ieee80211_tx_dequeue()").
> >
> > Hardware:
> > 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80=
MHz
> >
> > This debugging patch reveals that the change causes key to be NULL in
> > mt7921_tx_prepare_skb().
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/dri=
vers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > index 881812ba03ff..3b8552a1055c 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> > @@ -13,6 +13,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, vo=
id *txwi_ptr,
> >         struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_de=
v, mt76);
> >         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->s=
kb);
> >         struct ieee80211_key_conf *key =3D info->control.hw_key;
> > +       dev_info(mdev->dev, "%s: key =3D %px\n", __func__, key);
> >         struct mt76_connac_hw_txp *txp;
> >         struct mt76_txwi_cache *t;
> >         int id, pid;
> >
> >
> > So why is info->control.hw_key not updated by ieee80211_tx_h_select_ke=
y()?
> >
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index 34f229a6eab0..2510e3533d13 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -631,8 +631,10 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_dat=
a *tx)
> >  		case WLAN_CIPHER_SUITE_WEP40:
> >  		case WLAN_CIPHER_SUITE_WEP104:
> >  		case WLAN_CIPHER_SUITE_TKIP:
> > -			if (!ieee80211_is_data_present(hdr->frame_control))
> > +			if (!ieee80211_is_data_present(hdr->frame_control)) {
> > +				printk(KERN_INFO "%s %d: setting tx->key =3D NULL\n", __func__, _=
_LINE__);
> >  				tx->key =3D NULL;
> > +			}
> >  			break;
> >  		case WLAN_CIPHER_SUITE_CCMP:
> >  		case WLAN_CIPHER_SUITE_CCMP_256:
> > @@ -641,19 +643,23 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_da=
ta *tx)
> >  			if (!ieee80211_is_data_present(hdr->frame_control) &&
> >  			    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
> >  					       tx->skb) &&
> > -			    !ieee80211_is_group_privacy_action(tx->skb))
> > +			    !ieee80211_is_group_privacy_action(tx->skb)) {
> > +				printk(KERN_INFO "%s %d: setting tx->key =3D NULL\n", __func__, _=
_LINE__);
> >  				tx->key =3D NULL;
> > -			else
> > +			} else {
> >  				skip_hw =3D (tx->key->conf.flags &
> >  					   IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
> >  					ieee80211_is_mgmt(hdr->frame_control);
> > +			}
> >  			break;
> >  		case WLAN_CIPHER_SUITE_AES_CMAC:
> >  		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> >  		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> >  		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> > -			if (!ieee80211_is_mgmt(hdr->frame_control))
> > +			if (!ieee80211_is_mgmt(hdr->frame_control)) {
> > +				printk(KERN_INFO "%s %d: setting tx->key =3D NULL\n", __func__, _=
_LINE__);
> >  				tx->key =3D NULL;
> > +			}
> >  			break;
> >  		}
> >
> > @@ -662,9 +668,13 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_dat=
a *tx)
> >  			     tx->skb->protocol !=3D tx->sdata->control_port_protocol)
> >  			return TX_DROP;
> >
> > +		printk(KERN_INFO "%s: skip_hw=3D%d tx->key=3D%px\n",
> > +				__func__, skip_hw, tx->key);
> >  		if (!skip_hw && tx->key &&
> > -		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
> > +		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
> >  			info->control.hw_key =3D &tx->key->conf;
> > +			printk(KERN_INFO "%s: info->control.hw_key =3D %px\n", __func__, i=
nfo->control.hw_key);
> > +		}
> >  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta =
&&
> >  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
> >  		return TX_DROP;
> > @@ -3894,6 +3904,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee=
80211_hw *hw,
> >  	 * The key can be removed while the packet was queued, so need to ca=
ll
> >  	 * this here to get the current key.
> >  	 */
> > +	printk(KERN_INFO "%s: info->control.hw_key =3D %px, setting to NULL\=
n",
> > +			__func__, info->control.hw_key);
> >  	info->control.hw_key =3D NULL;
> >  	r =3D ieee80211_tx_h_select_key(&tx);
> >  	if (r !=3D TX_CONTINUE) {
> >
> > This patch reveals that tx->key is set to NULL (in the @@ -641,19 +643=
,23 @@ chunk)
> > and so the updating of info->contro.hw_key is skipped:
> >
> > [   17.411298] [   T1232] ieee80211_tx_h_select_key 647: setting tx->k=
ey =3D NULL
>
> That means that we are trying to send non management frames using
> AES_CMAC, or BIP_* cipher, aren't those ciphers used only for group
> management frames ?
>
> > [   17.411300] [   T1232] ieee80211_tx_h_select_key: skip_hw=3D0 tx->k=
ey=3D0000000000000000
> > [   17.411307] [   T1232] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb=
: key =3D 0000000000000000
> >
> > If I revert commit a104042e2bf6 while keeping the debug patches it sho=
ws that
> > the for mt7921e the key is never updated in ieee80211_tx_h_select_key(=
), mt7921e
> > relies on the key your patch is setting to NULL.
> >
> > Is this a problem with your patch or with the mt7921e driver that just=
 got
> > revealed by your patch?
>
> Not sure yet, do you happen to know which kind of frame mt7921e is
> trying to be sent using this NULL key ?
>
> Thanks,

I modified my debugging patch to print mgmt->frame_control, if needed I co=
uld
also insert a nore complicated function printing out frame types using the
ieee80211_is_*() functions:

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 881812ba03ff..cfbe7e1e4713 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -13,6 +13,9 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void
*txwi_ptr,
        struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev, m=
t76);
        struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
        struct ieee80211_key_conf *key =3D info->control.hw_key;
+       struct ieee80211_mgmt *mgmt =3D (void *)tx_info->skb->data;
+       __le16 fc =3D mgmt->frame_control;
+       dev_info(mdev->dev, "%s: key =3D %px fc =3D 0x%hx\n", __func__, ke=
y, fc);
        struct mt76_connac_hw_txp *txp;
        struct mt76_txwi_cache *t;
        int id, pid;

and get this, while unsuccesfully trying to connect (also note that one ti=
me
getting a key worked):

$ dmesg | grep prepare_skb
[   11.775642] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xb0
[   11.800047] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x0
[   13.365330] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xb0
[   13.370257] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x0
[   16.468481] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xb0
[   16.472407] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x0
[   16.542017] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[   16.549581] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[   16.597120] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   16.612263] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xd0

Here we actually go a key:
[   16.614478] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
ffff89c275297230 fc =3D 0x4188

[   16.654273] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   16.698286] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   17.735855] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   17.837355] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   17.851029] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   18.613079] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   18.786202] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   21.027478] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   21.150212] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   21.843201] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   25.769981] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   29.776926] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   34.424966] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   44.945880] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   50.670382] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   62.054907] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xc0
[   65.042457] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xb0
[   65.047387] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x0
[   65.391881] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[   65.405189] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[   65.445775] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   65.449289] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   65.479305] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xd0
[   65.854396] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xb0
[   65.878897] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x0
[   65.954047] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[   65.961191] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[   65.966296] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   65.977287] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xd0
[   66.117317] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   66.626938] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   66.700300] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   66.818440] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   67.347089] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   67.448947] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   67.649713] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   68.535890] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   69.537434] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   69.697331] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   69.866666] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   70.500294] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   71.537535] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   74.615436] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   75.543129] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   77.741585] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   83.309171] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[   83.550827] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   91.650611] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   99.564147] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[   99.625088] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[  111.050345] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xc0
[  114.346190] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xb0
[  114.370450] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x0
[  114.447350] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[  114.454710] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x188
[  114.494605] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[  114.520269] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xd0
[  114.522520] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
ffff89c2e7227230 fc =3D 0x4188
[  115.138564] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  115.394552] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  116.435866] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  116.494988] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[  116.612522] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  116.724047] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  117.459651] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  117.600286] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  118.816266] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[  118.961067] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  120.304632] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  121.614000] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  123.281756] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0xffff
[  127.930929] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333
[  129.617550] [   T1227] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D
0000000000000000 fc =3D 0x3333

Bert Karwatzki

