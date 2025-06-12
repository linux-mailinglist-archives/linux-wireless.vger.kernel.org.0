Return-Path: <linux-wireless+bounces-24029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B36EAD6646
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 05:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C62D1BC1697
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D01A2643;
	Thu, 12 Jun 2025 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q9wus7ov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB54690
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700333; cv=none; b=KP/nT38jBduM527q8CWxUrnJr/TCuQquczgLHfgiJFd6Ig0K1xObY+o4jmpTqQJdyLrMZaA0j5YmaixxhG/9DnA5+K93VfQDsS50MmCnGT8XHaqW5vxk6O7kQCBNdepIGacDsrTx3xBW+1ws4uOKFYPx4jLt1TWGQNChmdTE9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700333; c=relaxed/simple;
	bh=IFQnRbFAMSvVCiO5ytGISQ7DTbE+6iGbpFbZ7T4s8w0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8gJr+RZE1pNh6bBi0CnIgzJge93DkonL77qGmaxwh5Rvd6/e6KrGduTfONozE736FX8mRR6x0Uj3MH8WoauLtSGfNdjWsi2cf72iO2G+GaaAkqld1Ig2DpA8gw5JB/H4K9aTg5bhca+uzERdGy4SrcDRhW/3YWox9Wl7V/+S2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q9wus7ov; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55C3mq8I31855020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749700132; bh=pWW47s4e3j/22TaPu8xTPvC3T1NXSmPCdvp/ttEPts8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Q9wus7ovW3NtWHv+4HbpqM0koZgXq6Ct/a+BErdtCxIkgGIC8JQJfFDK23RXoXsB/
	 RtOiHxAU7FA51KxtH7+INWLV3qRh6qwIWhPva2g5l4Li3QpoKi/+wWTRsTJrnc/S4F
	 mQxg/tyUB3MVbv5y02/D9A1JD7mEwSi7P97aqhizLMYrdsZLTTlmIwI6iVapmpPjYJ
	 HbmsLQPK7Sxw2K7IUliJUY8JJMu1a8QZboWaGCHKMYF/uP3/7JhcBFkrqzqIZt+s3k
	 rNXygR8TkHprthm/DghVQEITQnwepRAA10KzH7qmepjPPwatfrhOMb2Dj7GdIP8qu9
	 HLc//KvxXX9Cg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55C3mq8I31855020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:48:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 11:48:53 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Jun 2025 11:48:53 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 12 Jun 2025 11:48:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: hzy15610046011 <houzhanyi61@buaa.edu.cn>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "StanleyYP.Wang@mediatek.com"
	<StanleyYP.Wang@mediatek.com>,
        "mingyen.hsieh@mediatek.com"
	<mingyen.hsieh@mediatek.com>,
        "chad@monroe.io" <chad@monroe.io>,
        "razvan.grigore@vampirebyte.ro" <razvan.grigore@vampirebyte.ro>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        "zhanyihou6011@gmail.com" <zhanyihou6011@gmail.com>
Subject: RE: [PATCH] Add non-null judgement branch for return value of  mt76_connac_get_he_phy_cap().
Thread-Topic: [PATCH] Add non-null judgement branch for return value of
  mt76_connac_get_he_phy_cap().
Thread-Index: AQHb2ta/usBjXSopdEGuxP/fZtaWcbP+4tww
Date: Thu, 12 Jun 2025 03:48:52 +0000
Message-ID: <f9689cd14c144a1cab4d0fe8bf0f6849@realtek.com>
References: <20250611134209.312009-1-houzhanyi61@buaa.edu.cn>
In-Reply-To: <20250611134209.312009-1-houzhanyi61@buaa.edu.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

hzy15610046011 <houzhanyi61@buaa.edu.cn> wrote:
>=20
> From: H-Mole <houzhanyi61@buaa.edu.cn>
>=20
> Since commit https://github.com/torvalds/linux/commit/f503ae90c7355e8506e=
68498fe84c1357894cd5b

The pattern to reference commit is "commit + 12digits + subject", such as:=
=20
   commit f503ae90c735 ("wifi: mt76: mt7996: fix NULL pointer dereference i=
n mt7996_mcu_sta_bfer_he")

>  showed that drivers/net/wireless/mediatek/mt76/mt7996/mcu.c misses a non=
-null judgement for the
>  return value of mt76_connac_get_he_phy_cap on variable vc, this null-poi=
nter problem may also happen
>  on mt7915. This commit added such non-null judgement like what was added=
 to function
> mt7996_mcu_sta_bfer_he()
>  in commit f503ae90c7355e8506e68498fe84c1357894cd5b.

Have you run checkpatch before sending out?

>=20
> Signed-off-by: H-Mole <houzhanyi61@buaa.edu.cn>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 427542777abc..5dca50d40080 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -1184,6 +1184,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, s=
truct ieee80211_vif *vif,
>         u8 nss_mcs =3D mt7915_mcu_get_sta_nss(mcs_map);
>         u8 snd_dim, sts;
>=20
> +       if (!vc)
> +               return;
> +

Before checking vc, ve is induced by vc already.=20

        const struct ieee80211_he_cap_elem *ve =3D &vc->he_cap_elem;

Though pointer doesn't really access the data, it would be better to get
the pointer after checking vc.

>         bf->tx_mode =3D MT_PHY_TYPE_HE_SU;
>=20
>         mt7915_mcu_sta_sounding_rate(bf);
> --
> 2.39.5
>=20


