Return-Path: <linux-wireless+bounces-29602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA47CADEF1
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 18:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59202304D9C6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2D757EA;
	Mon,  8 Dec 2025 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="rGjJMjJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55882C86D
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765215699; cv=none; b=IT8wfMa9iyXy/ApDsV6t9UbY6P6aTzoEUwLxoR+FqE5Y29nuw3OXcFWFslRhAZww3Avc/dnCII6pTNdp9tO07Yz6FWNt5Qilke7AXrDYYtTmb9oUqabYBvHbzPh+P3U6/xoQHa8+Rmaytgumid32K02JfKqHcWZrZmabisS1P5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765215699; c=relaxed/simple;
	bh=e1rXtyvBajDRd/1bByMPn2SeRe+Un+qMTq9dskhtGFU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoV23zVotVBUZqBH8bPt+4Ge2GVT9fh5KNXXEkW9X3SnpXsrguxupZOGYU0P4PnxmxzRw8diTBY2Mn4ctCw031dkP4sDS+WJQLwTo39siUoEvEeg1eZctyiz6RUEVOF6lufBtwela90FNMvq8LmJ1tnpoabgdWir65FmuRyfLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=fail smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=rGjJMjJi; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765215681; x=1765474881;
	bh=nAskoR/9df3vRQNCZZq1S3SyZ/pOxoExHCx2p7cwsAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rGjJMjJi++4oBCWomM2YHz3jUn3mhugd1p8DU4egRHn/Jt8OuyZxOEsT4dPR973It
	 niqOEUz7ytSMOMafiR5+Gbj/BsFzIFoKLPQhcnetFeBTBGa7+82GhOFf9ZI5jxFdYD
	 YJqHv7e5DrcUZ02nXlLmsmfHSbsVFtUHTJbnMiINwCLZ27akGdJZd+c1/uvyMY79GI
	 /vxE1bdbFj/CtI3AQy8+6yFYlaUo8jd0e6DnukEZZ+F5bJaMmXa7KyNp5GVbG6Rqz5
	 5XKqh3cuAW3O84P9appXejGZBP1D3RAIWwaz5kdPNFVNhHKPgEmix3uc0sddPiEO/5
	 qZyLhy6jTPmaw==
Date: Mon, 08 Dec 2025 17:41:17 +0000
To: Lorenzo Bianconi <lorenzo@kernel.org>
From: Chad Monroe <chad@monroe.io>
Cc: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: fix deadlock in remain-on-channel
Message-ID: <qa3DpeAFV4STXYZKtPG6DyXOAFGaiLxTbsmc30DyPFx7fkpq_m6uhMAlyHVCCf71N4-gphwqjmw1aFR26syHQeONYSFlxUicSEctFdZdSzs=@monroe.io>
In-Reply-To: <aTbed-BC8vEmwpzD@lore-desk>
References: <3fceebb12dcb672cfae11f993a373b457a35e228.1765198130.git.chad@monroe.io> <aTbed-BC8vEmwpzD@lore-desk>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: 830241bd499abb301524f1f45c2bdba5ff4df267
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Monday, December 8th, 2025 at 6:19 AM, Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:

>=20
>=20
> > mt76_remain_on_channel() and mt76_roc_complete() call mt76_set_channel(=
)
>=20
> > while already holding dev->mutex. Since mt76_set_channel() also acquire=
s
> > dev->mutex, this results in a deadlock.
> >=20
> > Use __mt76_set_channel() instead of mt76_set_channel().
> > Add cancel_delayed_work_sync() for mac_work before acquiring the mutex
> > in mt76_remain_on_channel() to prevent a secondary deadlock with the
> > mac_work workqueue.
>=20
>=20
> I think we need a Fixes tag here.
>=20
> Regards,
> Lorenzo
>=20

Good call.. added and submitted v2. Thank you,

    -Chad

> > Signed-off-by: Chad Monroe chad@monroe.io
> > ---
> > drivers/net/wireless/mediatek/mt76/channel.c | 13 +++++++++++--
> > 1 file changed, 11 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net=
/wireless/mediatek/mt76/channel.c
> > index 2b705bdb7993..d9f8529db7ed 100644
> > --- a/drivers/net/wireless/mediatek/mt76/channel.c
> > +++ b/drivers/net/wireless/mediatek/mt76/channel.c
> > @@ -326,7 +326,7 @@ void mt76_roc_complete(struct mt76_phy *phy)
> > mlink->mvif->roc_phy =3D NULL;
> > if (phy->main_chandef.chan &&
> > !test_bit(MT76_MCU_RESET, &dev->phy.state))
> > - mt76_set_channel(phy, &phy->main_chandef, false);
> > + __mt76_set_channel(phy, &phy->main_chandef, false);
> > mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
> > phy->roc_vif =3D NULL;
> > phy->roc_link =3D NULL;
> > @@ -370,6 +370,8 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw,=
 struct ieee80211_vif *vif,
> > if (!phy)
> > return -EINVAL;
> >=20
> > + cancel_delayed_work_sync(&phy->mac_work);
> > +
> > mutex_lock(&dev->mutex);
> >=20
> > if (phy->roc_vif || dev->scan.phy =3D=3D phy ||
> > @@ -388,7 +390,14 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw=
, struct ieee80211_vif *vif,
> > phy->roc_vif =3D vif;
> > phy->roc_link =3D mlink;
> > cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
> > - mt76_set_channel(phy, &chandef, true);
> > + ret =3D __mt76_set_channel(phy, &chandef, true);
> > + if (ret) {
> > + mlink->mvif->roc_phy =3D NULL;
> > + phy->roc_vif =3D NULL;
> > + phy->roc_link =3D NULL;
> > + mt76_put_vif_phy_link(phy, vif, mlink);
> > + goto out;
> > + }
> > ieee80211_ready_on_channel(hw);
> > ieee80211_queue_delayed_work(phy->hw, &phy->roc_work,
> > msecs_to_jiffies(duration));
> > --
> > 2.47.3

