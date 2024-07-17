Return-Path: <linux-wireless+bounces-10302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319CD933EAF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 16:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3FE281CA3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4D1802D2;
	Wed, 17 Jul 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Nm3QGNUG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C306224FA
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227118; cv=none; b=UaJAJqpXZm2ZMYR9Fgiq/+P9895rCX/nLFE2bnW3Bd6LFubROUGgTWly6V8WipJ4jfGwGliBcSlIeiRT0f1S5q8Q+e0JN8yY+iZJGLSGKTGb0ZhXQzFyD3sf9dKokqpYFXQ7RZgn0YoRWHO7HRnKw4nTfbHy0JZ92k7je8hQlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227118; c=relaxed/simple;
	bh=q3EcHBy1gN+Lo6ngi10nJ37xbA4XYBUM+rSnDjGcA3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJJ0xiDiABbffrDxld09dUbExFeUgk5W5XRntVOtKiHQU7Cgx61N1TuzK+nG0E4V+5ZDGJPLuf+MhCnYvwrfgQhzUnSA1Kd48kuIjULJb/jtXVOIk4QvJTefiRFBKrNYp8cW5ZpHiANqSDMJ9O9rlQPw+sVCO2Q+e5AMAN6/c1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Nm3QGNUG; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721227092; x=1721831892; i=spasswolf@web.de;
	bh=/OhCBxLbY39TdVn30H/TEG/qulkte7VCuRem2G4YsWM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nm3QGNUG97Pqbbcwl5U1uzTeUr1A1VrL47zj7X1WIKP70xVdpg7R9no1Qr5vyzv1
	 fzXAI0GN+kyMrpohjJ80NmROK+AKpSUf3X/My9WBtAT55q3XU/nd16Zv9/9GLwowf
	 4XXvPWUV+2ygYkXbtuZ4k+m/aL2RF1lK/ENRshuFG/LwoFNEbnCKCsoknddj0q+3i
	 51ZK74WfBF8rm5giKJCWJ+sTE903rvVCa2WXBFaAzyirQIeLCp8mKgeIz9dOWgK5L
	 ic8X6hqqoD4ZKerMq5pOZu3Ml/uuoF/AlLvkLESkwsAil3BmruE5vIINBZMpjorCp
	 xhjHIdnt9whKjvQIrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1sO1FS0O2w-0023mt; Wed, 17
 Jul 2024 16:38:12 +0200
Message-ID: <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
 linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
 mingyen.hsieh@mediatek.com, nbd@nbd.name, sean.wang@mediatek.com,
 spasswolf@web.de
Date: Wed, 17 Jul 2024 16:38:09 +0200
In-Reply-To: <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	 <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CrHSZLe45W7rrNLPM/1lE+MTJ2pQwQXYUvth51J0g3y3x+R7CCD
 ER1A3NOgRdpO9ErcW0q44w99QSW+zpMnDciYSi0rGj9dsZv5oWJWpy9XS5ip9SJXwzNYaCQ
 7Kyoy0AYQ9DiZ8dNejB9z6I1PDIco983nAKdjfrBHSHkhTb0kAJwXOVFqPxhXXccAcq2+bL
 asyZUpHNexzXEZ22w6bbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g09lkWUWwlM=;WokJo5OB1Z5qLQ9ldzMg0oYygh8
 dQsNI1tPUWa5DNUj4++3xMvtEexWnBcDnermt3bPYKFm0P1EXRQl22KKrKF5VrD016B+HtBVT
 HaGVWpPj1o1SoTW2iHo+ZiRp17gWtapX86kk8k8KyfWCF8nDypPVexR/7jg9bKl9xhIILjSvR
 yCKGJAV+RXSIkix7fSVxRmLou5CtBSvsJih5v/QaxduU72y+AZKYHps03GscN4OqF9cw7TWQo
 ZmLNVMvgw8052fmbmFXSxSa6D2SAye6QHYpCwzgC+HQ50wYLItXMt1AkDbTkZLjRrXFKEZUUC
 6N4VLhMvBZdJUp8OB1gEqtMB1PGyFtIGMEH8BMVfmh2FvBr8KEvASitxv8E4WJw60nABtgRPY
 XNj/F163zhy346PoGUMTbdQzA0kB8sH6wf2Tr6LraVJtIgBJBfMVMT9X23fmPZXtZwVdXORTF
 8YWJTSFVYmNRBgsbBIBP9cDJen+FVxajDpyOxeAglarQnaGTpZk5JRLudK30XYJVP4vTRmRXd
 Nlkc411RjPQdZaE2J6jY4D48TiEZZc/muVBrDJmuA9cX3kXSohwZNKHmG6HelC0+WsOu825rd
 tPsLLu79nuAomfRYnO14/rCuj8UvhOLcerZ64qPKmyc1vrGqxCviO7XQD5xvxstus7ZvU0rrV
 jGvRYCm7Ty5xQ1LzGHaZEOwjZpeN3OSaRDgzNURUkAd04weU1QDpCl3XBhMsTMyrlKLgq5u7P
 xPJ4nQQgMneE6jJyg4zFiV4wWNbyVqhjAoxozdu42MT8+lKisDP3+Pik5ChD3aYzk/D2tXu/0
 itTXtqoU3lH9cttMDytg/xog==

Am Freitag, dem 12.07.2024 um 13:06 +0200 schrieb Bert Karwatzki:
> Am Donnerstag, dem 11.07.2024 um 18:40 -0500 schrieb Sean Wang:
> > Hi Bert,
> >
> > Thanks for the detailed debug log. I've quickly made a change to fix
> > the issue. Right now, I can't access the test environment, but I'll
> > test it and send it out as soon as possible. Here's the patch.
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > index 2e6268cb06c0..1bab93d049df 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw,
> > struct ieee80211_vif *vif)
> >
> >         mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
> >         mvif->phy =3D phy;
> > +       mvif->bss_conf.vif =3D mvif;
> >         mvif->bss_conf.mt76.band_idx =3D 0;
> >         mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
> > MT76_CONNAC_MAX_WMM_SETS;
> >
>
> I wrote earlier that this patch works fine with linux-next-20240711 and =
at first
> it did, but then another NULL pointer error occured. I'm not sure if I c=
an
> bisect this as it does not trigger automatically it seems. Also I'm curr=
ently
> bisecting the problem with linux-20240712
>
> Bert Karwatzki

Now the above mentioned NULL pointer dereference has happended again, this=
 time
on linux-next-20240716. It cann be triggered by repeatedly turning the Wif=
i off
and on again. For further investigation I created this patch:

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..3ecedf7bc9f3 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -303,6 +303,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct
ieee80211_vif *vif)

 	mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
 	mvif->phy =3D phy;
+	WARN(!phy, "%s: phy =3D NULL\n", __func__);
+	mvif->bss_conf.vif =3D mvif;
 	mvif->bss_conf.mt76.band_idx =3D 0;
 	mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
MT76_CONNAC_MAX_WMM_SETS;

@@ -1182,6 +1184,12 @@ static void mt7921_ipv6_addr_change(struct ieee8021=
1_hw
*hw,
 				    struct inet6_dev *idev)
 {
 	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
+	printk(KERN_INFO "%s: mvif =3D %px\n", __func__, mvif);
+	printk(KERN_INFO "%s: mvif->phy =3D %px\n", __func__, mvif->phy);
+	if (!mvif->phy) {
+		printk(KERN_INFO "%s: mvif->phy =3D NULL\n", __func__);
+		return;
+	}
 	struct mt792x_dev *dev =3D mvif->phy->dev;
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];

And the result is this (the WARN in mt7921_add_interface did not trigger):

[  367.121740] [    T861] wlp4s0: deauthenticating from 54:67:51:3d:a2:d2 =
by
local choice (Reason: 3=3DDEAUTH_LEAVING)
[  367.209603] [    T861] mt7921_ipv6_addr_change: mvif =3D ffff954e7500de=
40
[  367.209615] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D 000000000=
0000000
[  367.209621] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D NULL
[  367.250026] [    T861] mt7921_ipv6_addr_change: mvif =3D ffff954e7500de=
40
[  367.250034] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D ffff954e4=
4427768
[  367.251537] [    T861] mt7921_ipv6_addr_change: mvif =3D ffff954e7500de=
40
[  367.251542] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D ffff954e4=
4427768
[  369.977123] [    T862] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (loc=
al
address=3Dc8:94:02:c1:bd:69)
[  369.984864] [    T862] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[  370.006199] [    T104] wlp4s0: authenticated
[  370.006680] [    T104] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/=
3)
[  370.059080] [     T98] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2
(capab=3D0x511 status=3D0 aid=3D2)
[  370.064067] [     T98] wlp4s0: associated

So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change. The earl=
y
return in that case avoids the NULL pointer and mvif->phy has its usual va=
lue
again on the next call to mt7921_ipv6_addr_change so Wifi is working again=
. I
don't know how this could happen but perhaps you have an idea.

Bert Karwatzki

