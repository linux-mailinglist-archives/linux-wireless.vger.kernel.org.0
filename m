Return-Path: <linux-wireless+bounces-33821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDwuBP+ew2nGsAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:38:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A453217E3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3BAD3016ADF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA193218B3;
	Wed, 25 Mar 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCcXmIll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51530F540
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427899; cv=none; b=m1SjbEV6zv7w5hVXxN8EkmNAKNR6zyRlcN1UAVOxEKcOdEneIM7YN7KIiSW0MI0b0p0EvID1mi0TA+YJ9ZMV/ygWogbrwBrZRa6yg2qPljd4bXeWScaNAj3ttOq6ncZ6REgNTmQUpDOCGxFFo97BuUC52W0I4cdmQpXGGhJu7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427899; c=relaxed/simple;
	bh=EM0+9tNtdiTwGPX1mNsPTcVBTrSGR7FlxukO3n8bNS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJYOQZaZRe6DYL5BpLj410crZlmrH4R9OtgMqdJONh0Yn1bH9l4a14xhL8WII8FppzNNbB9e/m947NnDaKcTZmV0fE3UzmJPXYt1YJaoGjO0leBDYEnR49vZ4FuuaTiO/KNrCZWMM+9ml/K+Gq9o5gbCgyp2qN5d+pfG6J+aEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCcXmIll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C36C4CEF7;
	Wed, 25 Mar 2026 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774427899;
	bh=EM0+9tNtdiTwGPX1mNsPTcVBTrSGR7FlxukO3n8bNS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCcXmIllWZeKF1/Z/hVrl9NVmEqKjENo7m3QZFAXIuKBxcOEe/OQ/JHJeXIHJ/CdK
	 uKairazOIxLS/qTL9BZRWoDVBY4YK1z3t2IRAYxh6LzbujIZ7sStEMj8v4/uypm4mr
	 lmmHNt8H5sEm6jOy5fGNGLddtIvnzk85jab/IFKMcbsu2QgDInKOe50E/SMTOgNIzb
	 krYN5rH8CftJfk7zzu6SX7juTi/nmEdvXy11FZSJG9KfkO0QiRyU6ilVZKCrtP56GT
	 Hil9OLOiG30pP5LEo3nSjPesbe7vh+Bg1ANS9SWiR4gkRQ9Sh+qYEG+FscxJnCuWze
	 Wrr3adCiENsOw==
Date: Wed, 25 Mar 2026 08:58:40 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: disable UNI_BSS_INFO_PROTECT_INFO
 for mt7996
Message-ID: <acOVsMnd_UQtS8h7@lore-rh-laptop>
References: <a1f5ad05b164c836161e9c53e32335c15a1fa2a2.1774411028.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ZliJ2s3U8pZrCt9"
Content-Disposition: inline
In-Reply-To: <a1f5ad05b164c836161e9c53e32335c15a1fa2a2.1774411028.git.ryder.lee@mediatek.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33821-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: A1A453217E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7ZliJ2s3U8pZrCt9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> There are known firmware issues with MT7996, so it is temporarily
> disabled. MT7992 and MT7990 are working normally.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 16420375112d..bdc40e94127c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -1281,6 +1281,9 @@ int mt7996_mcu_set_protection(struct mt7996_phy *ph=
y, struct mt7996_vif_link *li
>  		PROT_NONGF_STA	 =3D BIT(7),
>  	};
> =20
> +	if (is_mt7996(&dev->mt76))
> +		return 0;

Hi Ryder,

nit: can you please add a comment here describing why this is required? Tha=
nks.

Regard,
Lorenzo

> +
>  	skb =3D __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76,
>  					 MT7996_BSS_UPDATE_MAX_SIZE);
>  	if (IS_ERR(skb))
> --=20
> 2.45.2
>=20
>=20

--7ZliJ2s3U8pZrCt9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCacOVrgAKCRA6cBh0uS2t
rEEVAP46LkzCPwGF5e7kcW9FgtIk0MGvoM2dJPMHJ+w3b1d1yQD/eS7eMXImJkwA
GE6L/r5/7ZT5m7nI6geFnkq1BZ/tQwQ=
=EeR4
-----END PGP SIGNATURE-----

--7ZliJ2s3U8pZrCt9--

