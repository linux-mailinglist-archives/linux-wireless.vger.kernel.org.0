Return-Path: <linux-wireless+bounces-37234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFoVNt4fHWp9VwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:59:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF692619EE3
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FA14300A24D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BC3358B0;
	Mon,  1 Jun 2026 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX5kBpWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982932ED27;
	Mon,  1 Jun 2026 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293521; cv=none; b=bshj3qvaeRfkc5OLZCmYOKtB3kycMBucjOmKpGR3zDraONlEYvZgxxVWv3GZVG7o32tiKiUtjNpYoJlj1qoLwWzsPBPjwh+yRQJgEJfJUcfq1O8FlHCoUh3W9yyqCAZW0GMI6E5Ys6mnsjj6htKkX442nOMANAMAcBvUIZD9r8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293521; c=relaxed/simple;
	bh=hFnATE+6U1ZpGAPwjwddayrZceE0b3UECArd2QXSYQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm8/KnNSc7V4QclRPeOs1GuAM3QRTq0lXZFcofbLvP6PzUpRoR7uKXWecn/lRH8LoRf+1JOqqLYcCtdMcSvXAXSN8uGWkb5H5A8Y7GrOfqGC6GD7GQC2iH63+plvhBRyHX0WtE4dSvxEwbzZltof3QvVGa2iFjyCAv9rbWPxrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX5kBpWo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD361F00893;
	Mon,  1 Jun 2026 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780293520;
	bh=N8ZmOAtQgvXuoLmKd6WCIumh3x0pvVxkYVcX8hy5mGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TX5kBpWogNBnq7ueXJBbRDG8RSiNQDJYQsZsVJwAw+Sx0ec5M2tfUdiR51Vqqw5jn
	 JnUO4Dg67KKMRNHS1GnWVVqS1ptyGmtdJrtaDl3tjLIPHwb64pDhJnIuAJU55/IKzn
	 7aCIwjaoKQHla2d/N/C6yV1jVXWzLSFb8XsIqnWT1yqoKZVVCEUMJCc19zFhmYzdon
	 snynCKO/dAgGkM4PsZ98pWd54qURST2GDjaUkOkoCMhZFp0FBnlKwHyUdoZ++e5xQ4
	 Nf9kX6MDL3sv5m36Hh8D2PrH3uN32dpUQm+5yaaqrwRH5yszxkXtvl8FjHGXAoxwmp
	 ZTQeKagSpkzOA==
Date: Mon, 1 Jun 2026 07:56:41 +0200
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Ryder Lee <Ryder.Lee@mediatek.com>
Cc: Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	Chui-hao Chiu =?utf-8?B?KOmCseWegua1qSk=?= <Chui-hao.Chiu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Message-ID: <ah0fGek5y8Nha0kd@lore-rh-laptop>
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
 <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
 <ahwla_obwnwr2cZo@lore-desk>
 <44c54ed4da0d294c567b3b0ad750f082a6f1be9f.camel@mediatek.com>
 <ahwzwHDF7fT9t7hP@lore-desk>
 <7f02be7c4f919413718a0218b3792d4b0a222ca3.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzjsFj6KDcPkGXlo"
Content-Disposition: inline
In-Reply-To: <7f02be7c4f919413718a0218b3792d4b0a222ca3.camel@mediatek.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37234-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,collabora.com,vger.kernel.org,lists.infradead.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF692619EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wzjsFj6KDcPkGXlo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 31, Ryder Lee wrote:
> On Sun, 2026-05-31 at 15:12 +0200, lorenzo@kernel.org wrote:
> > On May 31, Ryder Lee wrote:
> > > On Sun, 2026-05-31 at 14:11 +0200, lorenzo@kernel.org=A0wrote:
> > > > > On Sun, 2026-05-31 at 10:55 +0200, Lorenzo Bianconi wrote:
> > > > > > mt76_tx_status_skb_add() zeroes the mt76_tx_cb struct stored
> > > > > > at
> > > > > > info->status.status_driver_data via memset(). Since info-
> > > > > > >control
> > > > > > and
> > > > > > info->status are members of the same union in
> > > > > > ieee80211_tx_info,
> > > > > > this overwrites info->control.flags.
> > > > > > In mt7996_tx_prepare_skb(), mt76_tx_status_skb_add() is
> > > > > > called
> > > > > > before
> > > > > > mt7996_mac_write_txwi(), which re-reads info->control.flags
> > > > > > to
> > > > > > extract
> > > > > > IEEE80211_TX_CTRL_MLO_LINK. Because the field has been
> > > > > > zeroed,
> > > > > > the
> > > > > > link_id always resolves to 0 for frames using global_wcid,
> > > > > > leading to
> > > > > > incorrect TXWI configuration.
> > > > > > Fix this by passing link_id as an explicit parameter to
> > > > > > mt7996_mac_write_txwi(). In mt7996_tx_prepare_skb(), the
> > > > > > link_id
> > > > > > is
> > > > > > already extracted from info->control.flags before the
> > > > > > destructive
> > > > > > mt76_tx_status_skb_add() call. For the beacon and inband
> > > > > > discovery
> > > > > > callers in mcu.c, use link_conf->link_id directly.
> > > > > >=20
> > > > > > Fixes: f0b0b239b8f36 ("wifi: mt76: mt7996: rework
> > > > > > mt7996_mac_write_txwi() for MLO support")
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Do not use link_id in mt7996_mac_write_txwi if it is
> > > > > > IEEE80211_LINK_UNSPECIFIED
> > > > > > - In mt7996_mac_write_txwi() rely on link_id calculated in
> > > > > > =A0 mt7996_tx_prepare_skb().
> > > > > > - Link to v1:
> > > > > > https://lore.kernel.org/r/20260530-mt76_tx_status_skb_add-overw=
rite-fix-v1-1-e2c3151c391a@kernel.org
> > > > > > =A0
> > > > > > ---
> > > > > > =A0drivers/net/wireless/mediatek/mt76/mt7996/mac.c=A0=A0=A0 | 14
> > > > > > ++++----
> > > > > > ----
> > > > > > --
> > > > > > =A0drivers/net/wireless/mediatek/mt76/mt7996/mcu.c=A0=A0=A0 |=
=A0 5 +++-
> > > > > > -
> > > > > > =A0drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |=A0 3 ++-
> > > > > > =A03 files changed, 9 insertions(+), 13 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > > > b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > > > index c98446057282..95b3078d9667 100644
> > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > > > > > @@ -856,7 +856,8 @@ mt7996_mac_write_txwi_80211(struct
> > > > > > mt7996_dev
> > > > > > *dev, __le32 *txwi,
> > > > > > =A0void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32
> > > > > > *txwi,
> > > > > > =A0			=A0=A0 struct sk_buff *skb, struct
> > > > > > mt76_wcid
> > > > > > *wcid,
> > > > > > =A0			=A0=A0 struct ieee80211_key_conf *key,
> > > > > > int
> > > > > > pid,
> > > > > > -			=A0=A0 enum mt76_txq_id qid, u32
> > > > > > changed)
> > > > > > +			=A0=A0 enum mt76_txq_id qid, u32
> > > > > > changed,
> > > > > > +			=A0=A0 unsigned int link_id)
> > > > > > =A0{
> > > > > > =A0	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr
> > > > > > *)skb-
> > > > > > > data;
> > > > > > =A0	struct ieee80211_tx_info *info =3D
> > > > > > IEEE80211_SKB_CB(skb);
> > > > > > @@ -866,7 +867,6 @@ void mt7996_mac_write_txwi(struct
> > > > > > mt7996_dev
> > > > > > *dev, __le32 *txwi,
> > > > > > =A0	bool is_8023 =3D info->flags &
> > > > > > IEEE80211_TX_CTL_HW_80211_ENCAP;
> > > > > > =A0	struct mt76_vif_link *mlink =3D NULL;
> > > > > > =A0	struct mt7996_vif *mvif;
> > > > > > -	unsigned int link_id;
> > > > > > =A0	u16 tx_count =3D 15;
> > > > > > =A0	u32 val;
> > > > > > =A0	bool inband_disc =3D !!(changed &
> > > > > > (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
> > > > > > @@ -874,17 +874,11 @@ void mt7996_mac_write_txwi(struct
> > > > > > mt7996_dev
> > > > > > *dev, __le32 *txwi,
> > > > > > =A0	bool beacon =3D !!(changed & (BSS_CHANGED_BEACON |
> > > > > > =A0				=A0=A0=A0
> > > > > > BSS_CHANGED_BEACON_ENABLED))
> > > > > > &&
> > > > > > (!inband_disc);
> > > > > > =A0
> > > > > > -	if (wcid !=3D &dev->mt76.global_wcid)
> > > > > > -		link_id =3D wcid->link_id;
> > > > > > -	else
> > > > > > -		link_id =3D u32_get_bits(info->control.flags,
> > > > > > -				=A0=A0=A0=A0=A0=A0
> > > > > > IEEE80211_TX_CTRL_MLO_LINK);
> > > > > > -
> > > > > > =A0	mvif =3D vif ? (struct mt7996_vif *)vif->drv_priv :
> > > > > > NULL;
> > > > > > =A0	if (mvif) {
> > > > > > =A0		if (wcid->offchannel)
> > > > > > =A0			mlink =3D rcu_dereference(mvif-
> > > > > > > mt76.offchannel_link);
> > > > > > -		if (!mlink)
> > > > > > +		if (!mlink && link_id !=3D
> > > > > > IEEE80211_LINK_UNSPECIFIED)
> > > > > > =A0			mlink =3D rcu_dereference(mvif-
> > > > > > > mt76.link[link_id]);
> > > > > > =A0	}
> > > > > > =A0
> > > > > > @@ -1096,7 +1090,7 @@ int mt7996_tx_prepare_skb(struct
> > > > > > mt76_dev
> > > > > > *mdev, void *txwi_ptr,
> > > > > > =A0	/* Transmit non qos data by 802.11 header and need
> > > > > > to
> > > > > > fill
> > > > > > txd by host*/
> > > > > > =A0	if (!is_8023 || pid >=3D MT_PACKET_ID_FIRST)
> > > > > > =A0		mt7996_mac_write_txwi(dev, txwi_ptr,
> > > > > > tx_info-
> > > > > > > skb,
> > > > > > wcid, key,
> > > > > > -				=A0=A0=A0=A0=A0 pid, qid, 0);
> > > > > > +				=A0=A0=A0=A0=A0 pid, qid, 0, link_id);
> > > > > > =A0
> > > > > > =A0	/* MT7996 and MT7992 require driver to provide the
> > > > > > MAC
> > > > > > TXP
> > > > > > for AddBA
> > > > > > =A0	 * req
> > > > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > > > b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > > > index 8be40d60ad29..a14c63438923 100644
> > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > > > > > @@ -3103,7 +3103,7 @@ mt7996_mcu_beacon_cont(struct
> > > > > > mt7996_dev
> > > > > > *dev,
> > > > > > =A0
> > > > > > =A0	buf =3D (u8 *)bcn + sizeof(*bcn);
> > > > > > =A0	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid,
> > > > > > NULL,
> > > > > > 0, 0,
> > > > > > -			=A0=A0=A0=A0=A0 BSS_CHANGED_BEACON);
> > > > > > +			=A0=A0=A0=A0=A0 BSS_CHANGED_BEACON, link_conf-
> > > > > > > link_id);
> > > > > > =A0
> > > > > > =A0	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
> > > > > > =A0}
> > > > > > @@ -3249,7 +3249,8 @@ int
> > > > > > mt7996_mcu_beacon_inband_discov(struct
> > > > > > mt7996_dev *dev,
> > > > > > =A0
> > > > > > =A0	buf =3D (u8 *)tlv + sizeof(*discov);
> > > > > > =A0
> > > > > > -	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid,
> > > > > > NULL,
> > > > > > 0, 0, changed);
> > > > > > +	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid,
> > > > > > NULL,
> > > > > > 0, 0,
> > > > > > +			=A0=A0=A0=A0=A0 changed, link_conf->link_id);
> > > > > > =A0
> > > > > > =A0	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
> > > > > > =A0
> > > > > > diff --git
> > > > > > a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > > > b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > > > index 0dc4198fcf8b..0d6488522ba7 100644
> > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> > > > > > @@ -874,7 +874,8 @@ void mt7996_mac_enable_nf(struct
> > > > > > mt7996_dev
> > > > > > *dev,
> > > > > > u8 band);
> > > > > > =A0void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32
> > > > > > *txwi,
> > > > > > =A0			=A0=A0 struct sk_buff *skb, struct
> > > > > > mt76_wcid
> > > > > > *wcid,
> > > > > > =A0			=A0=A0 struct ieee80211_key_conf *key,
> > > > > > int
> > > > > > pid,
> > > > > > -			=A0=A0 enum mt76_txq_id qid, u32
> > > > > > changed);
> > > > > > +			=A0=A0 enum mt76_txq_id qid, u32
> > > > > > changed,
> > > > > > +			=A0=A0 unsigned int link_id);
> > > > > > =A0void mt7996_mac_update_beacons(struct mt7996_phy *phy);
> > > > > > =A0void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
> > > > > > =A0void mt7996_mac_work(struct work_struct *work);
> > > > > >=20
> > > > > > ---
> > > > > > base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
> > > > > > change-id: 20260530-mt76_tx_status_skb_add-overwrite-fix-
> > > > > > 85818a9bb31f
> > > > > >=20
> > > > > > Best regards,
> > > > > >=20
> > > > > >=20
> > > > > We might expand flags further so this still doesn't solve the
> > > > > issue
> > > > > of
> > > > > flags being cleared - it only works for MLO flag. And the
> > > > > developers
> > > > > still won't easily notice that the flags are being cleared.
> > > >=20
> > > > My opinion is we should consider just upstream code and then
> > > > change
> > > > it as soon
> > > > as you post this new feature upstream, but I will let Felix
> > > > comments
> > > > on it.
> > > > Moreover, the proposed approach aligns link_id used in
> > > > mt7996_tx_prepare_skb()
> > > > to the one used in mt7996_mac_write_txwi() and fix a possible OOB
> > > > bug
> > > > in
> > > > mt7996_mac_write_txwi().
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > > >=20
> > > > >=20
> > >=20
> > > Just to tie in with this patch subject - I'm just thinking of a way
> > > to
> > > solve this once and for all. If the problem is reading zeroed info-
> > > > control.flags, wouldn't it be better to just pass a u32 flags,
> > > something like this:
> > >=20
> > > u32 flags =3D info->control.flags
> > >=20
> > > mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0,
> > > 			=A0=A0=A0=A0=A0 changed, flags);
> > >=20
> > > We can use all flags then.
> >=20
> > what about link_id? Should it be the same between
> > mt7996_tx_prepare_skb()
> > and mt7996_mac_write_txwi()?
> >=20
> >=20
> =20
> I mean the link_id is only corresponds to one specific flags bit of
> mac80211_tx_control_flags. But there are other bits that aren't
> handled. Wouldn't u32 flags make it more cleaner?

Yes, I got your point, but my concern is if we need to sync link_id between
mt7996_tx_prepare_skb() and mt7996_mac_write_txwi(). If so, I guess it is
much better to pass link_id explicitly to mt7996_mac_write_txwi() since it
does not just depended on mac80211_tx_control_flags and I think we should
not duplicate the logic in mt7996_mac_write_txwi(). Got my point?
If in the future (not required now) we need to pass mac80211_tx_control_fla=
gs
to mt7996_mac_write_txwi(), we will do it easily.

Regards,
Lorenzo

>=20
> Ryder
>=20
>=20

--wzjsFj6KDcPkGXlo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCah0fFgAKCRA6cBh0uS2t
rEUJAP9cw7n0ld9kt7adipEUeq8Xa+Mo1z5RCm5s8tUkFyHaogD+PFq1JsPllni7
lolW/EqZMwI69tCxVZdr80J41s02Vws=
=st0d
-----END PGP SIGNATURE-----

--wzjsFj6KDcPkGXlo--

