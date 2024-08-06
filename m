Return-Path: <linux-wireless+bounces-11008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E598E948D94
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C741F24E34
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D41BD51D;
	Tue,  6 Aug 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="oJ7lbiCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597813B2AC
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943400; cv=none; b=h3Tc7uSm53Y40ePlTLn85pbQpECWk4SbWEEMVc3Zo8PrGYFWHFyhgdacgnAlDdhQwaxOOn/LtWqpR+Yb/DDZdjzt8URwVCU4VpBzDmj38bdN+V6J0wP5c9xt4GfdoOyx7zH3PPSl4FzEV+Bgc9ha/pSXC2Jj+DBjuVmRDb/GTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943400; c=relaxed/simple;
	bh=thhyCG8O8U6kuKj9aIHpf7uV/qFOC0ybSHZeJOFTDEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kH/4v40cfs8f9w1tkRjEyLd81DMFSdRWJhNRORzA5of7nnqnuULPbbpcbxyvhyL7/C21twXl2avZbnjCcISRqoWww0rq1sR4kAGBqEDbKRtGWLqJmIkFNSZNGGwGg4Zi//kv6vibK7NYRvNY/nHtu1pG19kAa9LWnIgWYc89TXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=oJ7lbiCQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722943365; x=1723548165; i=spasswolf@web.de;
	bh=7xWKLX+TQ8lgw1qTY76UXfpS0ItWUagRIMGYR7j8nrY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oJ7lbiCQc8pp1b5aoHbiDawLLoSmZ/4NRU24YOu//mlFlPu5HZf8A44TjHiRtmSD
	 vlRUru4S/FhFQCX031vBWBMPFDKhvVO8hTyrxjz5yGUrOvOLWnePGqEaJYb0HdY/A
	 de5qxC/TZxnwhIh8DKwtCAefKxfpbsbY9pi2T//Twi89cQRAdy6gKXV/MD9u9uJRo
	 lF6qPVtu5dJw5+0XiXxaymbXz6dOywwld68UvnxrsdKCfqXgVkLVuDI1suDUet7ti
	 MXcAI7HY7VbKtAignyKAN6d86FOc2qxXa23BC9ikc671ffKAUOQv4oguw7WTzS/5l
	 FaV5bcnygQ7J8rrfmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9vi-1shTF1381q-00TRL5; Tue, 06
 Aug 2024 13:22:45 +0200
Message-ID: <e32ab97963e850b4425e4f5c45d2c502d50be480.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>, 
	deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de
Date: Tue, 06 Aug 2024 13:22:44 +0200
In-Reply-To: <87frrqkkpm.fsf@kernel.org>
References: <20240711175156.4465-1-spasswolf@web.de>
		<CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
		<adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
		<4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
		<2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
		<65621cad9a22df881745e9333a5c3696bdbb8df3.camel@web.de>
	 <87frrqkkpm.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gST20yxtMJVjZRb11EdUOk2IEKYFhTO57N0EUKBUyGeDUI8NoW0
 wvSBytxsHX1ICmU+gvfiSzHVyCjnomfNq1p4E+mlmANuBZSiLboPiq2ToVR02/AufM0sMXA
 1XJHuLJrHBP6yJ5dglSKjxNabxTEYuuVRZNzf98G/iukd5aSBvA+Cc3KrH6heiSiKyUkM1C
 Aot2CB2bOSF6TTDBBcw8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+iF3Prgvv1c=;22pWPW0OQuMK05MtcLjq5NR1DE5
 5zZ8yKMecNVP8n1//Bytt+79dpEyF2kxoxb8a+IJVk7eRv3ZWMZfrsOxic7uxV87CDs7RCsOY
 lsdrKAL8I/Tw33lycmVltHG88tl9s4WVa1+hfOKRcrDytEFWg3DO6ErrYZ5lFaLARNSZf2qfN
 UwZKeEkbbDViU2FSSQOBgbggDLRMl3AvqXe6/LHCEHIvRKhcN1yDPpiKDT2YRUi1hWcJ+WKPh
 6Kv5BXCs0iuxqC8tZu7qmiubxOQsTwGhrJLywJvJqFg9YulTuizItEpLokCr3P6yNlOGdMpim
 jdndWeW30vREqb+ckALCh2O9PCX6oNf7VtSiqKZylvpQ609LhE7AQF2SP2LjOpb/6qpg7v2UD
 UbyXb19tGV2blBENG8ohRTQj+H66yu5U/E8/mRA9xtZNdbP+qaYaZomNZrNcvck7LsiGvR+y+
 6uxDm+h16q+AlD5VIsMCVrveECGikMlstxjKKSr+zCNv81RboRVJmFnePn7GiFmyM4uFa7vlr
 WPA3szF1f4SytsoEi6hbdJeesDtTnlpzGM64STy0/Fh67mm2+jNUn+tka1hy8Yz4gQm+E2tTn
 2f3P/Tk0yw52hxNt/2fwoPz/BEcnbvEDoDVeYFZkLJ1f7c4tGTxyudBHyBVG0kPVA0iPjNvjj
 vGVmKudLrKswRJUlxepEEojgdbBrR0G4lPuMcHy2xFSY7C8VicPCSy2FyQwtUmO+HxOE3EN6R
 Df1WW002jO3doGu59R4Ga+uIZUpviT+UeN0L1ZkQms1mMkpmaIDF2Bl0tqGns3Aw2ZzaVLMSo
 qmbXvLtw1tLnCCpfmiXswTrw==

Am Mittwoch, dem 31.07.2024 um 11:51 +0300 schrieb Kalle Valo:
> Bert Karwatzki <spasswolf@web.de> writes:
>
> > Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
> >
> > > On 17.07.24 16:38, Bert Karwatzki wrote:
> > >
> > > > So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change. =
The early
> > > > return in that case avoids the NULL pointer and mvif->phy has its =
usual value
> > > > again on the next call to mt7921_ipv6_addr_change so Wifi is worki=
ng again. I
> > > > don't know how this could happen but perhaps you have an idea.
> > >
> > > This change should fix it: https://nbd.name/p/0747f54f
> > > Please test.
> >
> > The BUG is still present in linux-6.11-rc1.
>
> I'm not sure what's the status with this. There's one mt76 patch going
> to v6.11-rc2:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/co=
mmit/?id=3D6557a28f3e3a54cff4f0dcdd1dfa649b26557ab3
>
> But that looks to be a fix for a different problem, right? Felix, are
> you planning to submit that 0747f54f as a proper patch? I could then
> take it to wireless tree.
>
The Bug is still present in linux-6.11-rc2 and linux-next-20240806. Also t=
he
mvif->phy NULL check in the original patch is not neccessary (and feels a =
little
out of place as mvif->phy is not needed anymore). This patch is sufficient=
 to
fix the NULL pointer dereference:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1bab93d049df..23b228804289 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1183,7 +1183,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211=
_hw
*hw,
                                    struct inet6_dev *idev)
 {
        struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
-       struct mt792x_dev *dev =3D mvif->phy->dev;
+       struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
        struct inet6_ifaddr *ifa;
        struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
        struct sk_buff *skb;

Bert Karwatzki

