Return-Path: <linux-wireless+bounces-37325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HAnkHCHTH2roqQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:09:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9564635036
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 09:09:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hOsWvKuy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37325-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37325-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E7CD3016247
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8E2EA173;
	Wed,  3 Jun 2026 07:09:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4B2874F5
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 07:09:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470559; cv=none; b=ifjcvHzmWquUfH77N+Qxut5L3x3UghNbI9L1NbcHlyHpOSnL2reLwfCeJAn9YrZD9gvEDsuANQqi0QUNng1/IpfjfT27GWPiREfy1Ox1iWTLFclQ5koxpF7jBpe15cZ3PHMFhUBDnSE0zuHz7NbyrHVfhhIfgaOQ0JtYrF+KGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470559; c=relaxed/simple;
	bh=mZBCgxoyHokkNBracodJOnsDEQB48AIadZjEIjWOqhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3x14dzI0HEDLhh2/MFNUqKayLxjjIbkdHjw13qxapYsQO57t5YOaqiDRlSBAlui6Mww08YHsh1hMC7hvUVbBUuVNgg/cRQRo7noOUXtsS35YQt0keTuJtbZjdwkuF5A2IBjFt07PoPcky3nusi9mXAOXk4lRxVFhCRKd9M3VN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOsWvKuy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA591F00893;
	Wed,  3 Jun 2026 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470558;
	bh=tJ0eBPoOv/JpwRjPZ38KgLzK58Xw2bMW0W/NSctuIjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOsWvKuy+Pbscbm5sqjTueOn2Sn2balOIPVRPQpnUdQMgo6bHIGvnk/cchDYYHdao
	 E7zBrv8PZDLP+kCGfL0Pq8iGphuCFasANddvCOdZj1dww6Y3PNPzE33VhAieqHBMQE
	 fK3nWPy5Ue67WXtig0zQV6P/OMhMzqY9ElRC4VnKfqgCxHTMr56CGZOBi9PDehhW1M
	 tXNM6iczVV4xY7fxD9GfvMWmnh1SDXTxkxaU4dPIoAuuHSC183so4961vd2qiNXPwS
	 lg+4Da1NBF7wVe/5Ri6jgRCPQlPg3Laf5xBQiR7vZy77gE6BI3CqqzcQabGFbMzNDQ
	 pQgk0Jceoxm9Q==
Date: Wed, 3 Jun 2026 09:09:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: Fix possible token leak in
 mt7996_tx_prepare_skb()
Message-ID: <ah_TG4bkzitM4AER@lore-desk>
References: <20260531-mt7996_tx_prepare_skb-token-leack-v1-1-2b9c9f59ceb1@kernel.org>
 <80ff2108-dce3-4060-a8d0-59740979a99a@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdJq5GVxual618Pk"
Content-Disposition: inline
In-Reply-To: <80ff2108-dce3-4060-a8d0-59740979a99a@candelatech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37325-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dylan.eskew@candelatech.com,m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9564635036


--bdJq5GVxual618Pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lore,

Hi Dylan,

>=20
> We have been seeing the token memory leak in our custom kernel. After
> pulling your patch in, we are still getting the leak (validated with
> kmemleak). How did you figure out where this potential leak was? I want to
> determine if we are leaking because of our changes or if there's more are=
as
> for token leakage.

Can you please try to run kmemleak on Felix's tree to check if there are any
leftover leaks not fixed yet?

Regards,
Lorenzo

>=20
> -- Dylan
>=20
> On 5/31/26 2:10 AM, Lorenzo Bianconi wrote:
> > If link_conf or link_sta lookup fails in mt7996_tx_prepare_skb routine,
> > mt7996 driver leaks an already allocated tx token. Fix the issue
> > releasing the token in case of error.
> >=20
> > Fixes: 7ef0c7ad735b0 ("wifi: mt76: mt7996: Implement MLD address transl=
ation for EAPOL")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++++++--
> >   drivers/net/wireless/mediatek/mt76/tx.c         | 2 +-
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7996/mac.c
> > index c98446057282..8c56344d211b 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > @@ -1067,11 +1067,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev=
, void *txwi_ptr,
> >   		link_conf =3D rcu_dereference(vif->link_conf[wcid->link_id]);
> >   		if (!link_conf)
> > -			return -EINVAL;
> > +			goto error_relase_token;
> >   		link_sta =3D rcu_dereference(sta->link[wcid->link_id]);
> >   		if (!link_sta)
> > -			return -EINVAL;
> > +			goto error_relase_token;
> >   		dma_sync_single_for_cpu(mdev->dma_dev, tx_info->buf[1].addr,
> >   					tx_info->buf[1].len, DMA_TO_DEVICE);
> > @@ -1176,6 +1176,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,=
 void *txwi_ptr,
> >   	tx_info->nbuf =3D MT_CT_DMA_BUF_NUM;
> >   	return 0;
> > +
> > +error_relase_token:
> > +	mt76_token_release(mdev, id, NULL);
> > +	return -EINVAL;
> >   }
> >   u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
> > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wire=
less/mediatek/mt76/tx.c
> > index 22f9690634c9..f96d9c471853 100644
> > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > @@ -933,7 +933,7 @@ mt76_token_release(struct mt76_dev *dev, int token,=
 bool *wake)
> >   #endif
> >   	}
> > -	if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
> > +	if (wake && dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR =
&&
> >   	    dev->phy.q_tx[0]->blocked)
> >   		*wake =3D true;
> >=20
> > ---
> > base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
> > change-id: 20260531-mt7996_tx_prepare_skb-token-leack-82e240d8c66f
> >=20
> > Best regards,
>=20

--bdJq5GVxual618Pk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCah/TGwAKCRA6cBh0uS2t
rNbDAPwPu5r9lorwMXt2ieCx4e8ZOixDsiJeTJLhBI1PCwhZHgD/TD9Hgb+5876Y
J8R/PRU26mzWgUpnb1+WZKRZmUYovQY=
=BrEn
-----END PGP SIGNATURE-----

--bdJq5GVxual618Pk--

