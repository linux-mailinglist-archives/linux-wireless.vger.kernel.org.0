Return-Path: <linux-wireless+bounces-10616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EED93F3B7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B801F221E0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896F7441F;
	Mon, 29 Jul 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="E8kFx1dm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED223CE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251558; cv=none; b=fJgSYN1oKorLvdHyar09twEH5OTLHFTfxcoYryWj8FQezT0IsiQdNKZ3K6mOzdrLfIvSe2b8zq/jnPjlf1UQFQZDX1jXLRrLS9c3Xv5/tzd2oQpGolWh1O5aPs9NiAlQ9Hyu5r8f8FmSM7zVTmvzG/CLnOkRNl+yr/uf63ndGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251558; c=relaxed/simple;
	bh=KczlxJwvLb/gMnSYO7ImSnba6klbQdzw0b6viP7AWEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/98CNz2cIvJAPK4THtcilwI3vjPll7lMbxwfr4vUKJhZFQeoVoZ8tUDeRLLdT4ZXWP6Bntz5FtYdn22sHRCrrsKvLcSMV8lPP7tzOI+ZChBX4MXRDcM2vXSoBmtYp2ejlIHgi77CYHF2zYBF28kP08OLtbCWsAfHVF1qtI6Yeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=E8kFx1dm; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722251537; x=1722856337; i=spasswolf@web.de;
	bh=373Xd6dyy934ztzDW+fda1E/9NFwuo6oroUTGcI7MXg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E8kFx1dmqU/5hhqZRYOJ0oH3vTlF/wIIA9vtFBMhKOTj6hia0XQddovVC9kYIFox
	 xxiDOw/3e4VFOEeNJoYp42Z6/WRm0qWNN/TP4UsUjbOxEgZK6LOh5K3raww01+E/B
	 cZaakANEk58vxepPjOPqBFstcFp8htrZHsOgou3O/+OfMEX7KOB7vzzCKCDQQF88A
	 k3riYMnKYQ6CVj8p2DWNXsOz9oVBEqiqx3My8FnOaa3kaCtRx0OH4+wg0rfQYHh5J
	 oPvG7FALalqlGVEcmk7LG+i7qUWVNnYCd1O8nJaoKGDOh5Q4HyMuGHeDqH4H+xinw
	 4xdNaZHg/r6Nsg5qhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1sPpSo0i23-009CB3; Mon, 29
 Jul 2024 13:12:17 +0200
Message-ID: <65621cad9a22df881745e9333a5c3696bdbb8df3.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de
Date: Mon, 29 Jul 2024 13:12:15 +0200
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
X-Provags-ID: V03:K1:dRjJ0/4GnlWP4i7mxWW0JtIIwxqBxnqKBQc4z14H6z2OB4gl0Fr
 uYyphgoUY1ZuD1hESd7Giz+5rP2lXxn3jpg7yWgqnevX6wBgtwd1cz53WSIeGPmtXFceZ04
 nfPc4DItEzZ7IGvUToCBRgmb2o816uIWdcDbU2XYuP8nv8zQcIp0oSzohq0xmDZ57v5FVPC
 KPyNKUnkl5Y2sXY4rt11w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UalprcfjusQ=;BTzDiMugZoYzOUWdOD5ImiS4BI/
 oR6DXOZslIzQn3vlmqodqPGmEB6Cy9RFT0p5IvXwwm3irxHkt5sPRUwgYfbuddgafOrD+usiV
 H7YPmCz4ueKsgd0mGxqNqfmo2HnSxs6W79K6lx4sENIuXfCr2P9+x8zdMOXNbmPqr9qdxn4Gm
 27tUukP9evL7IZ8YTzqgN2h3/PDrxk7pDFoKoZe0+uKZdzKuyIqNWccOZlCOz+jmvWAVbs5Gt
 fRDOk6z/gNkP36R1gUy8oLujvCApArKRIBRl+MtnIvH2h8pXrnhGV7rsVLNMf6taXBjNXY2jq
 LzuQI5Og/87K8Xr8WX2CtRwA9b2xHA6Q3Si0wszAoqNLqxsInKXMkjm7524/uX6n4SInfQqUx
 l4bHtz+YVsnyJGSyPi+SbeJeeIiO1Tcx1pOHLbpptzowo6AR34yZ0UVT1pCdaxLXR/AsFBsQM
 8UQ23RsVHSP0ufs0gymERhVL6czzwQfD2QUo8wMg1fWJdHMhxe+Y566FMcYx6q/zWOw5rHkbf
 1Vil4kdhPugboDS7qUCXxYiLRpq32g9hlor0bTEerctYeLdGnxCvwzrSei5DmHS4dPAHqTsRp
 q7tyFwoDViyAJeBOdnCryoilOBpYg1TzcMnw/p7+JHQNT9/hM0u+Iyd9no30/sE5YuQV4/Tt9
 NvXQ2qqqCfvPhLIpVg4q1qUEH1TpyhS65VLq2GNwB85hJHOnzvuDtMlRD8E8KTUl1A2Ggka1s
 0kDfzM2PYfn3relg/7JS963p1LOIbFV64FWXYkyqVuYoSUByaLMEa10a0v0PAZwIwivSumgM4
 ltkelWlzbpO5e7pxiepYxuUg==

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

The BUG is still present in linux-6.11-rc1.

Bert Karwatzki

