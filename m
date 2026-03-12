Return-Path: <linux-wireless+bounces-33094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGtYKwiYsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:40:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DB2706A9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C983051A80
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B263BB9F3;
	Thu, 12 Mar 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmjorNFE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24903B7741
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311996; cv=none; b=AkXyI+L3l9J9S6EhSsYNZu3Ukx55Kv2ZtSo9ocKOToxM6oNXpKob0a6wkUR/E6QwlKv4NEYltF5BDRnrWQ/oL2zzgcL9Tn1xxaNXJs+9mO93ne1LEOzR98bVopTYlKXTmSjixk7U+qiPO7VPHra1mO4r8gJ65CxpM+/zl/horLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311996; c=relaxed/simple;
	bh=pDVbEPackjHOkDSkszUjMWANS+pLeXpAW11n0EUfPZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LssQlTwtJPaX26CastetSOzrbF3HMI6if4R0POpNExNIm8qzgnmvJj0mkLbZePsUgvJDueiE6GcmrYcZgjXmS64j6GodhYCtrT0OYG3T3X0hKbLBLUaq/sk5nk/g8e8RTMZNfsY08X/kDyILf7lo0A3X3jR/jy2MEN6ISJyOJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmjorNFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59C5C4CEF7;
	Thu, 12 Mar 2026 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773311996;
	bh=pDVbEPackjHOkDSkszUjMWANS+pLeXpAW11n0EUfPZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmjorNFECXNJEhIvMFPJMesvdQV53BZgUT9zKAHZH7ebZHaOxKcNRswBeoUjH2k73
	 E631tm6hRN3pWxf5kKU4+AqhISKwMz24d93WPDRAHeM18j8pZlIlkXQc4GecTpe5xR
	 gqipAG4U7ITlClII9Er+976ctAYk/A2PoK9ID6uVybupVDeRgRXDbH0xRNJAYyIXiA
	 XL2iHnrzvK3KCC4in6oL3QxN3FRv6FJdMdvTwrDDj5X+3t0AbHGJJor4bSP2z/Dzim
	 6GfEIY+RZCxDEGAspRxpnTzfKyAPtK/jajLG29R0DzPiwGguaZW8P+RSKIRpMnh7d4
	 SN3xXVg5Ny23g==
Date: Thu, 12 Mar 2026 11:39:53 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH mt76 1/6] wifi: mt76: mt7996: fix RRO EMU configuration
Message-ID: <abKX-Zzn12F11L9D@lore-desk>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iguTs+hpi+rd15oI"
Content-Disposition: inline
In-Reply-To: <20260312095724.2117448-1-shayne.chen@mediatek.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33094-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 312DB2706A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--iguTs+hpi+rd15oI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Peter Chiu <chui-hao.chiu@mediatek.com>
>=20
> Use the correct helper to update specific bitfields instead of
> overwriting the entire register.
>=20
> Fixes: eedb427eb260 ("wifi: mt76: mt7996: Enable HW RRO for MT7992 chipse=
t")
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 +--
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c  | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/init.c
> index 5aaa93767109..f3239f530aea 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -873,8 +873,7 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
>  			}
>  		} else {
>  			/* set emul 3.0 function */
> -			mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
> -				MT_RRO_3_0_EMU_CONF_EN_MASK);
> +			mt76_set(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
> =20
>  			mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE0,
>  				dev->wed_rro.addr_elem[0].phy_addr);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index a415cc610eee..86aaf0f29e28 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -2559,7 +2559,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
>  	mt7996_dma_start(dev, false, false);
> =20
>  	if (!is_mt7996(&dev->mt76) && dev->mt76.hwrro_mode =3D=3D MT76_HWRRO_V3)
> -		mt76_wr(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
> +		mt76_set(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
> =20
>  	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
>  		u32 wed_irq_mask =3D MT_INT_TX_DONE_BAND2 |
> --=20
> 2.51.0
>=20

--iguTs+hpi+rd15oI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabKX+QAKCRA6cBh0uS2t
rIx5AP0dKoujlT6i8aItT2p8vcGNJ/KD6Gf6Zvu4+zxi7rYu5wEAghyiR8aWNO46
mhR6BaScV2AVgazIBnR5cgjD2XmMWAQ=
=SIDW
-----END PGP SIGNATURE-----

--iguTs+hpi+rd15oI--

