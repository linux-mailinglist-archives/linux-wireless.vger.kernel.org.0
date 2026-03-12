Return-Path: <linux-wireless+bounces-33098-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGIZMFyasmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33098-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:50:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8922707EA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A14304FFBC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61B242D7B;
	Thu, 12 Mar 2026 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL43ccST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D8388E74
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312569; cv=none; b=PJRfRjo2+TOezqtOoNMj7LEP2QCIqpnYpK8sdj5iV/837icFJ4/hVbARAWtbwi3Iqaru2AD3X75hrNVBCQTYzo3FIrb8KOYh6czpM7M5ubZXsx7KrRgdSt3BfR273zyC0Gnoz5rsdXPFbKS4864t5bAXm9OLGNCr5IgdxumWOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312569; c=relaxed/simple;
	bh=K/Rm2ZVA9g3iMKUjwHXSc3uMxpSSU5EOmyzA01FNXaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSA6MnUYJcNUzZFaNMAVc+UlQRReyP1CKe35vK3SsME2MRO0DmkTY362YxY2SjDrUrC3lgWJBmzEoaQ15lDhrwLluKp0y4RumBLiAAmxDVad+8YuagqKg9hun5BX4guexHt5ivg7HUh7pJURAL8pK6W103bMqGhWxS6IpLhoAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL43ccST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B7C4CEF7;
	Thu, 12 Mar 2026 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773312569;
	bh=K/Rm2ZVA9g3iMKUjwHXSc3uMxpSSU5EOmyzA01FNXaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL43ccSTKwTRILCSL77fDKeqY4T4Y23LoLsFxjcyZiPyhW5k95AhPPQyUWzSogd0m
	 8XP+vO16IEpb1uyT6e4sGoO1MagSTcuXNBvMHhQ4elLjkQ/5Yx5KkP/wtj3hxGsIIN
	 S9rzgFP1uO9LEDK3Qhii1t2M6VGMCtrkBHxjfeIbkQQLUDpvBLpr9z0kuw/2feeRVV
	 TIp2Y9yechEuwRA0hfWBYKCBs33eWNlFoSR4c4IEaUXMNxaEjlNco5GNY7M2Qtt8RJ
	 d0UH5Sps+IoYfghQ0oQMJ1tLEo/rRN+Wb+qbHZat7Oi3G0gvfnc1phdOGcuObhpLPH
	 PsmqXGfA5PWrA==
Date: Thu, 12 Mar 2026 11:49:27 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH mt76 5/6] wifi: mt76: mt7996: fix the temporary buffer
 for calibration-free data
Message-ID: <abKaN35p0J67rMOa@lore-desk>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
 <20260312095724.2117448-5-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JxkxFHsinZbtXUnl"
Content-Disposition: inline
In-Reply-To: <20260312095724.2117448-5-shayne.chen@mediatek.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33098-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
X-Rspamd-Queue-Id: 1D8922707EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--JxkxFHsinZbtXUnl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>=20
> Move the declaration of buf[] outside the for loop.
>=20
> Fixes: 224c7c2be578 ("wifi: mt76: mt7996: apply calibration-free data fro=
m OTP")
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 2a9c59d15894..4c733f51a03e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -4104,6 +4104,7 @@ mt7996_mcu_get_cal_free_data(struct mt7996_dev *dev)
>  	}
> =20
>  	for (band =3D 0; band < __MT_MAX_BAND; band++) {
> +		u8 buf[MT7996_EEPROM_BLOCK_SIZE];

why are you moving buf here? It is only used in the inner block.

>  		const struct cal_free_data *cal;
>  		u16 prev_block_idx =3D -1;
>  		u16 adie_base;
> @@ -4126,13 +4127,13 @@ mt7996_mcu_get_cal_free_data(struct mt7996_dev *d=
ev)
>  			u16 eep_offset =3D cal[i].eep_offs;
>  			u16 block_idx =3D adie_offset / MT7996_EEPROM_BLOCK_SIZE;
>  			u16 offset =3D adie_offset % MT7996_EEPROM_BLOCK_SIZE;
> -			u8 buf[MT7996_EEPROM_BLOCK_SIZE];

I think we should always define and initialize buf array here, otherwise we
could use it with uninitialized values. Something like:

			u8 buf[MT7996_EEPROM_BLOCK_SIZE] =3D {};

Regards,
Lorenzo

> =20
>  			if (is_mt7996(&dev->mt76) && band =3D=3D MT_BAND1 &&
>  			    dev->var.type =3D=3D MT7996_VAR_TYPE_444)
>  				eep_offset -=3D MT_EE_7977BN_OFFSET;
> =20
>  			if (prev_block_idx !=3D block_idx) {
> +				memset(buf, 0, sizeof(buf));
>  				ret =3D mt7996_mcu_get_eeprom(dev, adie_offset, buf,
>  							    MT7996_EEPROM_BLOCK_SIZE,
>  							    EEPROM_MODE_EFUSE);
> --=20
> 2.51.0
>=20

--JxkxFHsinZbtXUnl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabKaNwAKCRA6cBh0uS2t
rBXBAP9RSlH676VWo+h9+lFqvRDR9X/ZhMCTg1PuqU4AexZ4UgD+N5G8WvApvQ4G
lDp6fTNiXfp4rT3dP5XTb6mjdhTzIQc=
=zfPc
-----END PGP SIGNATURE-----

--JxkxFHsinZbtXUnl--

