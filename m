Return-Path: <linux-wireless+bounces-37208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC0NB/wmHGr9KAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:18:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71581616071
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 294CF300C58F
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE438643B;
	Sun, 31 May 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6gMgoUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14032AAB5;
	Sun, 31 May 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229487; cv=none; b=o5mNcpuYmjTFGTQzdnOo1VYBQpRbOnppkNk/N2SPhNJ0f/UXfeazVuME3Kz2DHfwbXY9ZhwMXKJGyqcIXfxuxKEuUmgPUHzrisOX/hs/y2ATcET8XH4SpFtedwYy3BDUsK4qs/4inPVSfklxyK0WG9lgMzb9ynSKPj83mtNOS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229487; c=relaxed/simple;
	bh=qm+UQvFkfYcqMnwntSVaJdOWEyHbKesg/3YBz4a+ozg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3aQDWvRF4JAKY+I3jyyrC++2D53y7KJuYxvgYk3bzKoGye1+gRzpEGoawh2vlrUh6QC98wcNWveHVTozFzuNavNATsnFVP7qsMQT4VaybjQdDJ8zNz2Rp3yW54DKS4xr6RU2X4gzYM9qd3h4tEN7TvLsUepb1OtKT5PkyKdh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6gMgoUr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4C1F00893;
	Sun, 31 May 2026 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229485;
	bh=P5L7upYeeIi8suDApzBL/oP6wbVic2Bu4SntuPBJZbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X6gMgoUrEyec4TnHgnPYtpD0KiMTOxmWQ30Iuip+GMHsjTyHXL09UuUIaQgnDpk51
	 gdhvc5RHa40qZS7mKTUt3lqgjUTOmzLBdmGTJxVUw7spriJDkxfo391lcKpCKv2lI1
	 kXFy27h7w2+kgFUPDAF/icTiMXjz+LzKRmfQSpLtTaoZ7bc4Tt8uWPyHHy6t3/WpM0
	 a+uFGtnaT+wG7lwqdzE1h9Ddlrz9FWo26rkOyQwvj0ImFz02BJ2+cDQAYjM9cTdLOX
	 x4wG/GI8E7+Awn19M7VRVnHYBRcWBaMdjwu9xte4C9dCBDHob+/ahg5UcpgcLuICIm
	 uzM3DDxS+xLVQ==
Date: Sun, 31 May 2026 14:11:23 +0200
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Ryder Lee <Ryder.Lee@mediatek.com>
Cc: Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chui-hao Chiu =?utf-8?B?KOmCseWegua1qSk=?= <Chui-hao.Chiu@mediatek.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Message-ID: <ahwla_obwnwr2cZo@lore-desk>
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
 <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P2k2XuQn+hFS6sON"
Content-Disposition: inline
In-Reply-To: <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37208-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,collabora.com,gmail.com,vger.kernel.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71581616071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--P2k2XuQn+hFS6sON
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 2026-05-31 at 10:55 +0200, Lorenzo Bianconi wrote:
> > mt76_tx_status_skb_add() zeroes the mt76_tx_cb struct stored at
> > info->status.status_driver_data via memset(). Since info->control and
> > info->status are members of the same union in ieee80211_tx_info,
> > this overwrites info->control.flags.
> > In mt7996_tx_prepare_skb(), mt76_tx_status_skb_add() is called before
> > mt7996_mac_write_txwi(), which re-reads info->control.flags to
> > extract
> > IEEE80211_TX_CTRL_MLO_LINK. Because the field has been zeroed, the
> > link_id always resolves to 0 for frames using global_wcid, leading to
> > incorrect TXWI configuration.
> > Fix this by passing link_id as an explicit parameter to
> > mt7996_mac_write_txwi(). In mt7996_tx_prepare_skb(), the link_id is
> > already extracted from info->control.flags before the destructive
> > mt76_tx_status_skb_add() call. For the beacon and inband discovery
> > callers in mcu.c, use link_conf->link_id directly.
> >=20
> > Fixes: f0b0b239b8f36 ("wifi: mt76: mt7996: rework
> > mt7996_mac_write_txwi() for MLO support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Do not use link_id in mt7996_mac_write_txwi if it is
> > IEEE80211_LINK_UNSPECIFIED
> > - In mt7996_mac_write_txwi() rely on link_id calculated in
> > =A0 mt7996_tx_prepare_skb().
> > - Link to v1:
> > https://lore.kernel.org/r/20260530-mt76_tx_status_skb_add-overwrite-fix=
-v1-1-e2c3151c391a@kernel.org
> > =A0
> > ---
> > =A0drivers/net/wireless/mediatek/mt76/mt7996/mac.c=A0=A0=A0 | 14 ++++--=
------
> > --
> > =A0drivers/net/wireless/mediatek/mt76/mt7996/mcu.c=A0=A0=A0 |=A0 5 +++--
> > =A0drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |=A0 3 ++-
> > =A03 files changed, 9 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > index c98446057282..95b3078d9667 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > @@ -856,7 +856,8 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev
> > *dev, __le32 *txwi,
> > =A0void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
> > =A0			=A0=A0 struct sk_buff *skb, struct mt76_wcid
> > *wcid,
> > =A0			=A0=A0 struct ieee80211_key_conf *key, int pid,
> > -			=A0=A0 enum mt76_txq_id qid, u32 changed)
> > +			=A0=A0 enum mt76_txq_id qid, u32 changed,
> > +			=A0=A0 unsigned int link_id)
> > =A0{
> > =A0	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb-
> > >data;
> > =A0	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> > @@ -866,7 +867,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev
> > *dev, __le32 *txwi,
> > =A0	bool is_8023 =3D info->flags &
> > IEEE80211_TX_CTL_HW_80211_ENCAP;
> > =A0	struct mt76_vif_link *mlink =3D NULL;
> > =A0	struct mt7996_vif *mvif;
> > -	unsigned int link_id;
> > =A0	u16 tx_count =3D 15;
> > =A0	u32 val;
> > =A0	bool inband_disc =3D !!(changed &
> > (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
> > @@ -874,17 +874,11 @@ void mt7996_mac_write_txwi(struct mt7996_dev
> > *dev, __le32 *txwi,
> > =A0	bool beacon =3D !!(changed & (BSS_CHANGED_BEACON |
> > =A0				=A0=A0=A0 BSS_CHANGED_BEACON_ENABLED)) &&
> > (!inband_disc);
> > =A0
> > -	if (wcid !=3D &dev->mt76.global_wcid)
> > -		link_id =3D wcid->link_id;
> > -	else
> > -		link_id =3D u32_get_bits(info->control.flags,
> > -				=A0=A0=A0=A0=A0=A0 IEEE80211_TX_CTRL_MLO_LINK);
> > -
> > =A0	mvif =3D vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
> > =A0	if (mvif) {
> > =A0		if (wcid->offchannel)
> > =A0			mlink =3D rcu_dereference(mvif-
> > >mt76.offchannel_link);
> > -		if (!mlink)
> > +		if (!mlink && link_id !=3D IEEE80211_LINK_UNSPECIFIED)
> > =A0			mlink =3D rcu_dereference(mvif-
> > >mt76.link[link_id]);
> > =A0	}
> > =A0
> > @@ -1096,7 +1090,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev
> > *mdev, void *txwi_ptr,
> > =A0	/* Transmit non qos data by 802.11 header and need to fill
> > txd by host*/
> > =A0	if (!is_8023 || pid >=3D MT_PACKET_ID_FIRST)
> > =A0		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb,
> > wcid, key,
> > -				=A0=A0=A0=A0=A0 pid, qid, 0);
> > +				=A0=A0=A0=A0=A0 pid, qid, 0, link_id);
> > =A0
> > =A0	/* MT7996 and MT7992 require driver to provide the MAC TXP
> > for AddBA
> > =A0	 * req
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > index 8be40d60ad29..a14c63438923 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > @@ -3103,7 +3103,7 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev,
> > =A0
> > =A0	buf =3D (u8 *)bcn + sizeof(*bcn);
> > =A0	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL,
> > 0, 0,
> > -			=A0=A0=A0=A0=A0 BSS_CHANGED_BEACON);
> > +			=A0=A0=A0=A0=A0 BSS_CHANGED_BEACON, link_conf-
> > >link_id);
> > =A0
> > =A0	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
> > =A0}
> > @@ -3249,7 +3249,8 @@ int mt7996_mcu_beacon_inband_discov(struct
> > mt7996_dev *dev,
> > =A0
> > =A0	buf =3D (u8 *)tlv + sizeof(*discov);
> > =A0
> > -	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL,
> > 0, 0, changed);
> > +	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL,
> > 0, 0,
> > +			=A0=A0=A0=A0=A0 changed, link_conf->link_id);
> > =A0
> > =A0	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
> > =A0
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > index 0dc4198fcf8b..0d6488522ba7 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > @@ -874,7 +874,8 @@ void mt7996_mac_enable_nf(struct mt7996_dev *dev,
> > u8 band);
> > =A0void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
> > =A0			=A0=A0 struct sk_buff *skb, struct mt76_wcid
> > *wcid,
> > =A0			=A0=A0 struct ieee80211_key_conf *key, int pid,
> > -			=A0=A0 enum mt76_txq_id qid, u32 changed);
> > +			=A0=A0 enum mt76_txq_id qid, u32 changed,
> > +			=A0=A0 unsigned int link_id);
> > =A0void mt7996_mac_update_beacons(struct mt7996_phy *phy);
> > =A0void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
> > =A0void mt7996_mac_work(struct work_struct *work);
> >=20
> > ---
> > base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
> > change-id: 20260530-mt76_tx_status_skb_add-overwrite-fix-85818a9bb31f
> >=20
> > Best regards,
> >=20
> >=20
> We might expand flags further so this still doesn't solve the issue of
> flags being cleared - it only works for MLO flag. And the developers
> still won't easily notice that the flags are being cleared.

My opinion is we should consider just upstream code and then change it as s=
oon
as you post this new feature upstream, but I will let Felix comments on it.
Moreover, the proposed approach aligns link_id used in mt7996_tx_prepare_sk=
b()
to the one used in mt7996_mac_write_txwi() and fix a possible OOB bug in
mt7996_mac_write_txwi().

Regards,
Lorenzo

> =20
> Our current approach is to move memset after mt7996_mac_write_txwi().
> It's more flexible and we don't have to constantly change the function
> parameters just for the flags.
>=20
> Ryder
>=20

--P2k2XuQn+hFS6sON
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahwlawAKCRA6cBh0uS2t
rKORAP4xNNufYg7cAAPnJ9TllbMFutlHnvbgIqWZb1VXVY1LLwEAlIlQ/MTLm3km
7YBsN8YIUqxvIry/08pV0fgPshColwA=
=F+cG
-----END PGP SIGNATURE-----

--P2k2XuQn+hFS6sON--

