Return-Path: <linux-wireless+bounces-37411-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcQoC1SiImoYbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37411-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 12:17:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE76473CF
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 12:17:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JEk2MPYd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37411-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37411-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 239A7301954B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553623EAB3;
	Fri,  5 Jun 2026 10:17:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B13F4DF2
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 10:17:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654673; cv=none; b=jc0EdROGZ3f7mLpCZye8EUv1Po+NEI46Mb87Td0uDGEDNgyVn3wAeyNW+BbpMovc/iZKSdQKEtuSkvMqPso9ikN4+QTXWQmUnKSwrTdEg3G71Ymp0yp5GSu/mrOElg79y34vuBYAi1p6OsTfuWHH6Rs1mwCP6tTQHyqABvX2dE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654673; c=relaxed/simple;
	bh=20P9ybhZ2NnwJz9JDSwgQpyQ5o4/xB1p/bzuRhJfcTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWm2GcjXL11PuA0Z+DFbfAYfts2Ezb8KFyhPmAaj9Ze7fV9tZHOQTP0lqdPC1/Gk3KNTWWpsRuLQFqXvf1NRlAyHqCAFx4kdmOiVnYPwoOWAgM42uBHPhAArbq1x9GPM7N1se+PWpF/tTzC/4BA/iQ1mv7LjMZmm+Nu5LRIzQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEk2MPYd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A21F00893;
	Fri,  5 Jun 2026 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654672;
	bh=AwnyOUcz5FBUq0T3U/kXkfVtKXtqDQbUmSU8IVzwYkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JEk2MPYdXHjuvnK9VFBM9Pj4rtMN+Wc6zIp5g2XhwmIHJXq8aZBryU4g6hGVGnNat
	 A8/GSIXcmD6q0aww3pa+EIfMlOa9Oq6uYD/usLIcwMSonv3p/MpQ+gbjH+E2xf+nwR
	 kJdeRS9SfGANDeCFTcq3PtleJO4SCoWQngB4LDOPLQf9OgRePUilNeVHmHPAj69hZU
	 5gk05DeRhXGOsu1B+9EG3bfs6Uj6gksdcYZU+HZlRoEtrxA1BMXvWYpaecuwj0b5xq
	 OGvHMcTIKhhMps/0rn/ZkSEeoPZstm4GWsO13KSbl/c/MBRvVRYiO1fF8NvRBfOj1v
	 LMy9PZS3B/sPg==
Date: Fri, 5 Jun 2026 12:17:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: fix potential tx_retries underflow
Message-ID: <aiKiTk32PW3_0pDg@lore-desk>
References: <20260605024222.3388222-1-ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ic/8nm7vBVUL+Ixi"
Content-Disposition: inline
In-Reply-To: <20260605024222.3388222-1-ryder.lee@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37411-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ryder.lee@mediatek.com,m:nbd@nbd.name,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:shayne.chen@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCAE76473CF


--ic/8nm7vBVUL+Ixi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When FIELD_GET returns 0 for the retry count, subtracting 1 causes
> an unsigned integer underflow, resulting in tx_retries becoming a
> very large value (0xFFFFFFFF for u32 or 255 for u8).
>=20
> Fix by checking if count is non-zero before subtracting 1.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

I guess we need proper Fixes tags here. Moreover, if you split this patch
in three separated patches you will make life easier for guys that do
backports :)

> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 +++++-----
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c |  5 +++--
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c |  5 +++--
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  6 +++---
>  4 files changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index cec2c4208..334c19ab2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -912,16 +912,16 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *da=
ta, int len)
>  		}
> =20
>  		if (!mtk_wed_device_active(&mdev->mmio.wed) && wcid) {
> -			u32 tx_retries =3D 0, tx_failed =3D 0;
> +			u32 tx_retries =3D 0, tx_failed =3D 0, count;
> =20
>  			if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3)) {
> -				tx_retries =3D
> -					FIELD_GET(MT_TX_FREE_COUNT_V3, info) - 1;
> +				count =3D FIELD_GET(MT_TX_FREE_COUNT_V3, info);
> +				tx_retries =3D count ? count - 1 : 0;

nit: I think it is more readable if you use a int for tx_retries and do
something like:
				tx_retries =3D max_t(int, tx_retries, 0);

This is valid even for below chunks.

Regards,
Lorenzo

>  				tx_failed =3D tx_retries +
>  					!!FIELD_GET(MT_TX_FREE_STAT_V3, info);
>  			} else if (!v3 && (info & MT_TX_FREE_MPDU_HEADER)) {
> -				tx_retries =3D
> -					FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
> +				count =3D FIELD_GET(MT_TX_FREE_COUNT, info);
> +				tx_retries =3D count ? count - 1 : 0;
>  				tx_failed =3D tx_retries +
>  					!!FIELD_GET(MT_TX_FREE_STAT, info);
>  			}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 03b4960db..668bfa195 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -530,8 +530,9 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev=
, void *data, int len)
>  		stat =3D FIELD_GET(MT_TX_FREE_STATUS, info);
> =20
>  		if (wcid) {
> -			wcid->stats.tx_retries +=3D
> -				FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
> +			u32 count =3D FIELD_GET(MT_TX_FREE_COUNT, info);
> +
> +			wcid->stats.tx_retries +=3D count ? count - 1 : 0;
>  			wcid->stats.tx_failed +=3D !!stat;
>  		}
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mac.c
> index c47bd812b..c56a9e530 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> @@ -1141,8 +1141,9 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *da=
ta, int len)
> =20
>  		if (info & MT_TXFREE_INFO_HEADER) {
>  			if (wcid) {
> -				wcid->stats.tx_retries +=3D
> -					FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
> +				u32 count =3D FIELD_GET(MT_TXFREE_INFO_COUNT, info);
> +
> +				wcid->stats.tx_retries +=3D count ? count - 1 : 0;
>  				wcid->stats.tx_failed +=3D
>  					!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
>  			}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index a59c14c8f..3fad977ba 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1361,13 +1361,13 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *=
data, int len)
>  				cur_info++;
>  			continue;
>  		} else if (info & MT_TXFREE_INFO_HEADER) {
> -			u32 tx_retries =3D 0, tx_failed =3D 0;
> +			u32 tx_retries =3D 0, tx_failed =3D 0, count;
> =20
>  			if (!wcid)
>  				continue;
> =20
> -			tx_retries =3D
> -				FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
> +			count =3D FIELD_GET(MT_TXFREE_INFO_COUNT, info);
> +			tx_retries =3D count ? count - 1 : 0;
>  			tx_failed =3D tx_retries +
>  				!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
> =20
> --=20
> 2.45.2
>=20
>=20

--ic/8nm7vBVUL+Ixi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiKiTgAKCRA6cBh0uS2t
rOZaAP9hR3f52SqEmn8nienu5aMDF9bJPs2/bD60VTSUL1gQRgEAtgycPcdkTBxW
wd3woNrHhswyJl95AcOeLBFqOUefTQY=
=3Kcw
-----END PGP SIGNATURE-----

--ic/8nm7vBVUL+Ixi--

