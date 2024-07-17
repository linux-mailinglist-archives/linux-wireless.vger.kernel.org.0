Return-Path: <linux-wireless+bounces-10310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23C93412B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEDB1F247CC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B61822DF;
	Wed, 17 Jul 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="g3XoKAhz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67E17E914
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235971; cv=none; b=tDD3myEJV1nzQHFUaImo7722FoZBXEBqlD6UshXcQj9xEZsGZFYXS4MHxA8pcxlXFQz3fO6RTwMRr/YO47cJ3cerNPA7HKmN2LAX0ZURP7FSAf9wMFi3eMbeBgfaZl0NVHFMBubGppg0w5sPZFMTpt3diKhSbMMdx6Qnbjhc5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235971; c=relaxed/simple;
	bh=S3lHqHTQgfmjhveeTzjasOsVgA8xNBXOvzjPHcLEYzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EViZXvDt02MMarTQvIoyq9wVDF+yjvBBwxDNdKjTEWi9VScXOga6dGT0IEOO3GXzfws99RZuV1FCqKr1rYMYH36f+x1avR+296TZa9eRITFB/cSgrHZhQy9DH7utLMtomRxUlCLf8YK7hvdUCV+Y1PN9MoR5EpPj5uf8xpdYtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=g3XoKAhz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721235947; x=1721840747; i=spasswolf@web.de;
	bh=JS9l16PVBf3CPuE/IoF9QcmvRwbKgU8Emdyp10Gv804=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g3XoKAhz9Q9NkOsGcMVY3z3gXVtSlVRjt1PKVhV7t22EhOnSj2e9I6FzfLGEwcNS
	 Eao6HSjRiWfE1060q6/5FB2eixJwdfRJunu7Lkeztlre9twBC5U4IvL1Ko4InhGfD
	 1t/iv1HPZGdebIsZCJg+OG5UKIlIT6yURS9T9guxqB3Rk6jJvYB4G8dtUk9qQfSD+
	 WMepDGW7LjlV3DbPg0I/KAyQAgbURoNZ2ODShnqqNJ4FPB1eof6/JwdTdtpWeM3XM
	 pdl4osKbvx8p7vVu1EokuKAxP6cLUOkOv3McNae4qpCg5yMTcdJBI2evY+wbMTvZk
	 PQRV3va9xIUYZlRR5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Ij-1s9H3w0TtL-00wlrp; Wed, 17
 Jul 2024 19:05:47 +0200
Message-ID: <9fb7ac97d2ca472db469aefefbfeb94e0f886508.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de
Date: Wed, 17 Jul 2024 19:05:45 +0200
In-Reply-To: <2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	 <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
	 <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
	 <2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Y0zIpG0dEUlu94qLZ2BTXfr7UbIgXbOKFrRqnfHQZE9mH+mRjm
 BmvbJ3OQBjSwNwMoqJ2fbpkAyv0lGxffcYIjMNo/LIAudWMmKnCi5ilBqw1tmQyHI3lp356
 07FzFWxbQ2OZHwsuPhVnSuCyX2f6LNinQ1O/3DsgwQBCqqYr29Il03ZNDo/cxusUecx0pnG
 X2sI0c0sYtKrbBgsXjZaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Aj5SW7ozQHw=;rSwDhhEwSHY1/mjriirHhfFm06x
 ay6BbyENr6BSjuHp0WyPa3dIDw3actF27zcLYJAHLokyMw+XAUn2by+KCbQuCXQqXFAaC6v80
 qX+V1noW2cMQrbTdjWQU+lRvl9r4XOxBBitom8k61+orRvnehEdDAYqyxuhej//z9ojouqsLt
 aIiVLLiJu/610cR4ZjF5hbJwhB2ZCYTNitj4Y/BoQBuCnMCFDYKI22VA9Pbcmug2AJFHvGsgP
 k+XXBlCoNlsDUW2LTlmvHw8v8MEWAZljC/tazafm287sh8/jjBrmV2K6jyaOSnH0PiLlKTX5S
 zBkqDbykUnfEvgOYFnhc/NGgODiYXhD1OCdF/2XJATExImWd92oEM2u+Enz/oSG0QOZWC2bh3
 adOWLFQvo6ftgpKtaEXaWXisNuoTMHCQCOsAceTdw7Yjd2cew9MJgJ61YuQPknHQWFENigZJR
 9Ad7PTXzhSde5HePyKga22FEz8Tj497Tjm9R0phgoyJC8ZJcexHo+rznD/50ISYpdVEsiPoD0
 sQ24WmAyZRb+wRx/8tVg+4i5nDSd4JtPPpNfeHihwkM3Z40nfS+OEKCaOTq6DweyFg4l74bXB
 Bd43Qz1iabf9bqoMsfV4N5f+k5JCDfxYaquCQ1pvsmUBj4yUuZUZkC9wBEzdwzE+nYIsM6+O7
 ox/yRGr8XwFj0fReRGSehaNuqleVuNJWz8+sUs639GMn0szdYc3vQf2BmaHLrMywGnMGFoJqY
 3b1bxd8QjtcQqG+eKZvHd5YymX5Bsh61wbIWZS/fJxdgNcjRvSaaDD1R+N0jP8PriDRdYLuPe
 4FPvT2z8yvZoCpYCUMxcaKiQ==

Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
> On 17.07.24 16:38, Bert Karwatzki wrote:
> > Am Freitag, dem 12.07.2024 um 13:06 +0200 schrieb Bert Karwatzki:
> > > Am Donnerstag, dem 11.07.2024 um 18:40 -0500 schrieb Sean Wang:
> > > > Hi Bert,
> > > >
> > > > Thanks for the detailed debug log. I've quickly made a change to f=
ix
> > > > the issue. Right now, I can't access the test environment, but I'l=
l
> > > > test it and send it out as soon as possible. Here's the patch.
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > index 2e6268cb06c0..1bab93d049df 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > > @@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw,
> > > > struct ieee80211_vif *vif)
> > > >
> > > >         mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
> > > >         mvif->phy =3D phy;
> > > > +       mvif->bss_conf.vif =3D mvif;
> > > >         mvif->bss_conf.mt76.band_idx =3D 0;
> > > >         mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
> > > > MT76_CONNAC_MAX_WMM_SETS;
> > > >
> > >
> > > I wrote earlier that this patch works fine with linux-next-20240711 =
and at first
> > > it did, but then another NULL pointer error occured. I'm not sure if=
 I can
> > > bisect this as it does not trigger automatically it seems. Also I'm =
currently
> > > bisecting the problem with linux-20240712
> > >
> > > Bert Karwatzki
> >
> > Now the above mentioned NULL pointer dereference has happended again, =
this time
> > on linux-next-20240716. It cann be triggered by repeatedly turning the=
 Wifi off
> > and on again. For further investigation I created this patch:
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > index 2e6268cb06c0..3ecedf7bc9f3 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > @@ -303,6 +303,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, stru=
ct
> > ieee80211_vif *vif)
> >
> >   	mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
> >   	mvif->phy =3D phy;
> > +	WARN(!phy, "%s: phy =3D NULL\n", __func__);
> > +	mvif->bss_conf.vif =3D mvif;
> >   	mvif->bss_conf.mt76.band_idx =3D 0;
> >   	mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
> > MT76_CONNAC_MAX_WMM_SETS;
> >
> > @@ -1182,6 +1184,12 @@ static void mt7921_ipv6_addr_change(struct ieee=
80211_hw
> > *hw,
> >   				    struct inet6_dev *idev)
> >   {
> >   	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> > +	printk(KERN_INFO "%s: mvif =3D %px\n", __func__, mvif);
> > +	printk(KERN_INFO "%s: mvif->phy =3D %px\n", __func__, mvif->phy);
> > +	if (!mvif->phy) {
> > +		printk(KERN_INFO "%s: mvif->phy =3D NULL\n", __func__);
> > +		return;
> > +	}
> >   	struct mt792x_dev *dev =3D mvif->phy->dev;
> >   	struct inet6_ifaddr *ifa;
> >   	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
> >
> > And the result is this (the WARN in mt7921_add_interface did not trigg=
er):
> >
> > [  367.121740] [    T861] wlp4s0: deauthenticating from 54:67:51:3d:a2=
:d2 by
> > local choice (Reason: 3=3DDEAUTH_LEAVING)
> > [  367.209603] [    T861] mt7921_ipv6_addr_change: mvif =3D ffff954e75=
00de40
> > [  367.209615] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D 00000=
00000000000
> > [  367.209621] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D NULL
> > [  367.250026] [    T861] mt7921_ipv6_addr_change: mvif =3D ffff954e75=
00de40
> > [  367.250034] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D ffff9=
54e44427768
> > [  367.251537] [    T861] mt7921_ipv6_addr_change: mvif =3D ffff954e75=
00de40
> > [  367.251542] [    T861] mt7921_ipv6_addr_change: mvif->phy =3D ffff9=
54e44427768
> > [  369.977123] [    T862] wlp4s0: authenticate with 54:67:51:3d:a2:d2 =
(local
> > address=3Dc8:94:02:c1:bd:69)
> > [  369.984864] [    T862] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try =
1/3)
> > [  370.006199] [    T104] wlp4s0: authenticated
> > [  370.006680] [    T104] wlp4s0: associate with 54:67:51:3d:a2:d2 (tr=
y 1/3)
> > [  370.059080] [     T98] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2
> > (capab=3D0x511 status=3D0 aid=3D2)
> > [  370.064067] [     T98] wlp4s0: associated
> >
> > So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change. The =
early
> > return in that case avoids the NULL pointer and mvif->phy has its usua=
l value
> > again on the next call to mt7921_ipv6_addr_change so Wifi is working a=
gain. I
> > don't know how this could happen but perhaps you have an idea.
>
> This change should fix it: https://nbd.name/p/0747f54f
> Please test.
>
> Thanks,
>
> - Felix
>

Your fix works. (I added a WARN() statement on the early return, to see if=
 mvif-
>phy actually was NULL during testing).

Bert Karwatzki


