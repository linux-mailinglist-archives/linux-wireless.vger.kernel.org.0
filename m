Return-Path: <linux-wireless+bounces-37207-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7zbsE0wjHGrCKAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37207-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:02:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0397615F28
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43D723004DCB
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E6175A89;
	Sun, 31 May 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCsAs0BI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EC26ACC
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780228936; cv=none; b=l/R0CxJtfj6UKxcnysyTd2lkdOHr9gPSyUGPNhRI2vplecI6YhgzT/NZ7x0Dei6H4iH6s9L4wM2K1T/frxv7xlUpy53W/Q6r8YsXAHz6sKfYq8TvowAXEQl9L28qWVtavKtMtpMQlYXQH2Hq/tcetxfQSnHL+U6lN8qEb0XGECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780228936; c=relaxed/simple;
	bh=8OXlZqplz5EJaAwwpFbU6KkkIj2OwZzcfMQWrGxPvxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJfqcg7ewBDFpwe+c4/7mAY0rxwkIivg7EO3CUlSmsn/ZqFngbUiOReOlS1aot42Kvtf8eLJDmcDg+2MBGP4f8caJwayr0oZl/0y7OM28enJQnTGyiSlHaaMnwHQaJuwKECrD3FjAEM+2q2vaJMj37PCqjD3NiIOWWh9NoG8+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCsAs0BI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CD01F00893;
	Sun, 31 May 2026 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780228935;
	bh=LUA8MZ0qh2JERp9jx3QhDjJg4JTy0gE/+OT/MQjp0aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KCsAs0BItthabkIDr8M6X/91txUAhEVYUIYP+lv5QyYIK5Gd4Cu244tiOc+nHotlo
	 KlMGb9oyaY6cLm2jVzI3K1vST/+pyxXvME2kolvmT1boa7Lkw4tqXpYrJ5262UEFWF
	 Atiw/jpGhQglV5izW/1Pu3y3AZ0bI+mxpwFMiW3t73YwvfUZBSc7bjtoBSt5FqYUFe
	 sxeCc+3GhxyTIpcIfIuwID02JvDOiakH88tJq1cqN7hdbNJCRgatI98GL4btAG8HIK
	 v4DDqY/OYyWiGl5Dja3BiIlWlk7wbfjEjDJJSKpgznkJ6d9AKCeiN8Q8GmYg203vuO
	 kVjb3CFxPwVfg==
Date: Sun, 31 May 2026 14:02:12 +0200
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Ryder Lee <Ryder.Lee@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chui-hao Chiu =?utf-8?B?KOmCseWegua1qSk=?= <Chui-hao.Chiu@mediatek.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Message-ID: <ahwjRJ5VqWFj9Sze@lore-desk>
References: <20260530-mt76_tx_status_skb_add-overwrite-fix-v1-1-e2c3151c391a@kernel.org>
 <6be1d6e67bcb5500c9d1e92449ce7757f6166d22.camel@mediatek.com>
 <ahvewFh2NuB5MO8t@lore-desk>
 <d756865286a14cf8402510817bd702228013fe8a.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oXUPI1TH9o+o2F9W"
Content-Disposition: inline
In-Reply-To: <d756865286a14cf8402510817bd702228013fe8a.camel@mediatek.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37207-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.infradead.org,mediatek.com,nbd.name,collabora.com,gmail.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0397615F28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--oXUPI1TH9o+o2F9W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 31, Ryder Lee wrote:
> On Sun, 2026-05-31 at 09:09 +0200, lorenzo@kernel.org wrote:
> > > On Sat, 2026-05-30 at 17:25 +0200, Lorenzo Bianconi wrote:
> > > > mt76_tx_status_skb_add() zeroes the mt76_tx_cb struct stored at
> > > > info->status.status_driver_data via memset(). Since info->control
> > > > and
> > > > info->status are members of the same union in ieee80211_tx_info,
> > > > this overwrites info->control.flags.
> > > > In mt7996_tx_prepare_skb(), mt76_tx_status_skb_add() is called
> > > > before
> > > > mt7996_mac_write_txwi(), which re-reads info->control.flags to
> > > > extract
> > > > IEEE80211_TX_CTRL_MLO_LINK. Because the field has been zeroed,
> > > > the
> > > > link_id always resolves to 0 for frames using global_wcid,
> > > > leading to
> > > > incorrect TXWI configuration.
> > > > Fix this by passing link_id as an explicit parameter to
> > > > mt7996_mac_write_txwi(). In mt7996_tx_prepare_skb(), the link_id
> > > > is
> > > > already extracted from info->control.flags before the destructive
> > > > mt76_tx_status_skb_add() call. For the beacon and inband
> > > > discovery
> > > > callers in mcu.c, use link_conf->link_id directly.
> > > >=20
> > > > Fixes: f0b0b239b8f36 ("wifi: mt76: mt7996: rework
> > > > mt7996_mac_write_txwi() for MLO support")
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > =A0drivers/net/wireless/mediatek/mt76/mt7996/mac.c=A0=A0=A0 | 9 +++=
------
> > > > =A0drivers/net/wireless/mediatek/mt76/mt7996/mcu.c=A0=A0=A0 | 5 +++=
--
> > > > =A0drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 ++-
> > > > =A03 files changed, 8 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > index c98446057282..2d3f80b3e41a 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > @@ -856,7 +856,8 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev
> > > > *dev, __le32 *txwi,
> > > > =A0void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
> > > > =A0			=A0=A0 struct sk_buff *skb, struct mt76_wcid
> > > > *wcid,
> > > > =A0			=A0=A0 struct ieee80211_key_conf *key, int
> > > > pid,
> > > > -			=A0=A0 enum mt76_txq_id qid, u32 changed)
> > > > +			=A0=A0 enum mt76_txq_id qid, u32 changed,
> > > > +			=A0=A0 unsigned int link_id)
> > > > =A0{
> > > > =A0	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb-
> > > > > data;
> > > > =A0	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> > > > @@ -866,7 +867,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev
> > > > *dev, __le32 *txwi,
> > > > =A0	bool is_8023 =3D info->flags &
> > > > IEEE80211_TX_CTL_HW_80211_ENCAP;
> > > > =A0	struct mt76_vif_link *mlink =3D NULL;
> > > > =A0	struct mt7996_vif *mvif;
> > > > -	unsigned int link_id;
> > > > =A0	u16 tx_count =3D 15;
> > > > =A0	u32 val;
> > > > =A0	bool inband_disc =3D !!(changed &
> > > > (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
> > > > @@ -876,9 +876,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev
> > > > *dev, __le32 *txwi,
> > > > =A0
> > > > =A0	if (wcid !=3D &dev->mt76.global_wcid)
> > > > =A0		link_id =3D wcid->link_id;
> > > > -	else
> > > > -		link_id =3D u32_get_bits(info->control.flags,
> > > > -				=A0=A0=A0=A0=A0=A0
> > > > IEEE80211_TX_CTRL_MLO_LINK);
> > > > =A0
> > > > =A0	mvif =3D vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
> > > > =A0	if (mvif) {
> > > > @@ -1096,7 +1093,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev
> > > > *mdev, void *txwi_ptr,
> > > > =A0	/* Transmit non qos data by 802.11 header and need to
> > > > fill
> > > > txd by host*/
> > > > =A0	if (!is_8023 || pid >=3D MT_PACKET_ID_FIRST)
> > > > =A0		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info-
> > > > >skb,
> > > > wcid, key,
> > > > -				=A0=A0=A0=A0=A0 pid, qid, 0);
> > > > +				=A0=A0=A0=A0=A0 pid, qid, 0, link_id);
> > > > =A0
> > > > =A0	/* MT7996 and MT7992 require driver to provide the MAC
> > > > TXP
> > > > for AddBA
> > > > =A0	 * req
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > index 8be40d60ad29..a14c63438923 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > @@ -3103,7 +3103,7 @@ mt7996_mcu_beacon_cont(struct mt7996_dev
> > > > *dev,
> > > > =A0
> > > > =A0	buf =3D (u8 *)bcn + sizeof(*bcn);
> > > > =A0	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid,
> > > > NULL,
> > > > 0, 0,
> > > > -			=A0=A0=A0=A0=A0 BSS_CHANGED_BEACON);
> > > > +			=A0=A0=A0=A0=A0 BSS_CHANGED_BEACON, link_conf-
> > > > > link_id);
> > > > =A0
> > > > =A0	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
> > > > =A0}
> > > > @@ -3249,7 +3249,8 @@ int mt7996_mcu_beacon_inband_discov(struct
> > > > mt7996_dev *dev,
> > > > =A0
> > > > =A0	buf =3D (u8 *)tlv + sizeof(*discov);
> > > > =A0
> > > > -	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid,
> > > > NULL,
> > > > 0, 0, changed);
> > > > +	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid,
> > > > NULL,
> > > > 0, 0,
> > > > +			=A0=A0=A0=A0=A0 changed, link_conf->link_id);
> > > > =A0
> > > > =A0	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
> > > > =A0
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > index 0dc4198fcf8b..0d6488522ba7 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > @@ -874,7 +874,8 @@ void mt7996_mac_enable_nf(struct mt7996_dev
> > > > *dev,
> > > > u8 band);
> > > > =A0void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
> > > > =A0			=A0=A0 struct sk_buff *skb, struct mt76_wcid
> > > > *wcid,
> > > > =A0			=A0=A0 struct ieee80211_key_conf *key, int
> > > > pid,
> > > > -			=A0=A0 enum mt76_txq_id qid, u32 changed);
> > > > +			=A0=A0 enum mt76_txq_id qid, u32 changed,
> > > > +			=A0=A0 unsigned int link_id);
> > > > =A0void mt7996_mac_update_beacons(struct mt7996_phy *phy);
> > > > =A0void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
> > > > =A0void mt7996_mac_work(struct work_struct *work);
> > >=20
> > > The reason we didn't make the same change is because we use other
> > > control flags (IEEE80211_TX_CTRL*) of info->control.flags not just
> > > MLO
> > > one. So with this change we still need to copy over the other flags
> > > and
> > > pass them in as well.
> >=20
> > Do you mean you are using info->control.flags in
> > mt7996_mac_write_txwi() in
> > some downstream code? If so, I guess you can use a similar approach
> > and
> > just pass the required field. Copy the full ieee80211_tx_info struct
> > on
> > per-packet basis seems unnecessary.
> >=20
> > Regards,
> > Lorenzo
> > >=20
> > >=20
>=20
> We will use 3 mac80211_tx_control_flags (i.e.
> IEEE80211_TX_CTRL_RATE_INJECT), so it's better to at least copy info-
> >control.flags directly and pass them in. If you pass each
> individually, the function will end up with 12 parameters, and if more
> flags are needed in the future, you will have to add even more.

But this is necessary for non-upstream code IIUC. Are you going to post it
upstream along with the fix?
I guess it is better to align the link_id used in mt7996_mac_write_txwi()
to the one used in mt7996_mac_write_txwi(). Please take a look to v3.

Regards,
Lorenzo

>=20
> Ryder

--oXUPI1TH9o+o2F9W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahwjRAAKCRA6cBh0uS2t
rLuBAQDq9iyy0731dRptZn+95HMBWHV5vheW8HVMIPcCtp+qogEAgnKGaE3gpDC0
PzdEgzAlQBJMZxaye7W2Pizk5lCAtQA=
=wGhD
-----END PGP SIGNATURE-----

--oXUPI1TH9o+o2F9W--

