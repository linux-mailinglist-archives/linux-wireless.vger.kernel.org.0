Return-Path: <linux-wireless+bounces-33096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE1uBveYsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:44:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921EC27072D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 266D7305C4AB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B938D006;
	Thu, 12 Mar 2026 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSDk72xi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE930BBAE
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312174; cv=none; b=untRTNdwtoKUpHfVLl16KzFJvFvgYBBuSGsybwIugloyWVOnL7zhbmFjmk2eiQ9nl21VoY15gjtnOHu0xaVQbRjeUOqTUISZBUV14KdQNU5tO+kvFZbj2ydqqZqcaRGu1bqi1GDdzZKf8cPpJ2dyIqCkfuq0UhgpMwS6El9eGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312174; c=relaxed/simple;
	bh=XythYX4gT7H5OoNToAuaNhuR3mg0cAF7Ixe3wtnxTcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBWAevQkC2yHgbdONESPjCPUO2U2lxGaf+dk6dHEmv4TuQTespznzOivAYB0TYUoGXqL7qyCdqDNhiQ5O7QpLMJ8aw6zTvsFdJmm0LFqim6tmiTVo5eJ5ieboVGW1bORB+oNqbTvWvVbLTCw23rHCNk0WIHFX4Lwh5LN46LwFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSDk72xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E171AC4CEF7;
	Thu, 12 Mar 2026 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773312174;
	bh=XythYX4gT7H5OoNToAuaNhuR3mg0cAF7Ixe3wtnxTcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSDk72xioRnWeo7OhjH9kfVPaHZE3kpvYUk6LY06P0HHEeVn96GGup6AoSRtYGWJJ
	 1nUqtU1CS7jJxOu3R78qGw8RHrvuUGbNEwuXrBKAlzcEIE1OSYo+pvrIGcwPoa8MaS
	 WMuXpvmcHiDfOHGvFjhdvfRyd1yibBVitbifecSgb6pTk4rEZJupQSm0hlNWoqzJy0
	 siUPkQh3yuLQwGn6IOdHGOKzggfa1o2JDLFrZNR6/5UeizNWYfiPhpqxHxaXBrvRx7
	 e7lXi8wK7LRqoTUBVIcJEokRI4/7/eVibdwAjo+5BcpR12SnHzhY7DcuJAfnaCceZf
	 M/zBgQ+cr652g==
Date: Thu, 12 Mar 2026 11:42:51 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH mt76 3/6] wifi: mt76: mt7996: update WFSYS reset flow for
 MT7990 chipsets
Message-ID: <abKYq0-OrV7-sE_i@lore-desk>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
 <20260312095724.2117448-3-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FP1s9Lrv1CHcNv+X"
Content-Disposition: inline
In-Reply-To: <20260312095724.2117448-3-shayne.chen@mediatek.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33096-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 921EC27072D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--FP1s9Lrv1CHcNv+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Peter Chiu <chui-hao.chiu@mediatek.com>
>=20
> Skip WFSYS reset during bootup for MT7990 chipsets; only reset if L0.5
> recovery is triggered.
> Without this fix, the following kernel error may occur:
> Internal error: synchronous external abort.

I guess we are missing a Fixes tag here.

Regards,
Lorenzo

>=20
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7996/init.c  | 29 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7996/regs.h  |  8 +++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/init.c
> index f3239f530aea..8dfb81eabc9a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -791,11 +791,34 @@ static void mt7996_init_work(struct work_struct *wo=
rk)
> =20
>  void mt7996_wfsys_reset(struct mt7996_dev *dev)
>  {
> -	mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
> -	msleep(20);
> +	if (!is_mt7990(&dev->mt76)) {
> +		mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
> +		msleep(20);
> +
> +		mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
> +		msleep(20);
> +
> +		return;
> +	}
> =20
> -	mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
> +	if (!dev->recovery.hw_full_reset)
> +		return;
> +
> +	mt76_set(dev, MT_WF_SUBSYS_RST,
> +		 MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT |
> +		 MT_WF_SUBSYS_RST_BYPASS_WFDMA_SLP_PROT |
> +		 MT_WF_SUBSYS_RST_BYPASS_WFDMA2_SLP_PROT);
> +	mt76_rmw(dev, MT_WF_SUBSYS_RST,
> +		 MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT_CYCLE,
> +		 u32_encode_bits(0x20, MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT_CYCLE));
> +	mt76_clear(dev, MT_WF_L05_RST, MT_WF_L05_RST_WF_RST_MASK);
> +	mt76_set(dev, MT_WF_SUBSYS_RST, MT_WF_SUBSYS_RST_WHOLE_PATH_RST);
>  	msleep(20);
> +
> +	if (mt76_poll(dev, MT_WF_L05_RST, MT_WF_L05_RST_WF_RST_MASK, 0x1a, 1000=
))
> +		return;
> +
> +	dev_err(dev->mt76.dev, "wfsys reset fail\n");
>  }
> =20
>  static void mt7996_rro_hw_init_v3(struct mt7996_dev *dev)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7996/regs.h
> index 393faae2d52b..c6379933b6c3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
> @@ -736,7 +736,15 @@ enum offs_rev {
>  #define MT_HW_REV				0x70010204
>  #define MT_HW_REV1				0x8a00
> =20
> +#define MT_WF_L05_RST				0x70028550
> +#define MT_WF_L05_RST_WF_RST_MASK		GENMASK(4, 0)
> +
>  #define MT_WF_SUBSYS_RST			0x70028600
> +#define MT_WF_SUBSYS_RST_WHOLE_PATH_RST		BIT(0)
> +#define MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT	BIT(5)
> +#define MT_WF_SUBSYS_RST_BYPASS_WFDMA_SLP_PROT	BIT(6)
> +#define MT_WF_SUBSYS_RST_BYPASS_WFDMA2_SLP_PROT	BIT(16)
> +#define MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT_CYCLE	GENMASK(15, 8)
> =20
>  /* PCIE MAC */
>  #define MT_PCIE_MAC_BASE			0x74030000
> --=20
> 2.51.0
>=20

--FP1s9Lrv1CHcNv+X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabKYqwAKCRA6cBh0uS2t
rLByAP4rQLda5B9RDQpzpqYXM3FYHvraDADlPAx27/reyQf0IwEAw1H/wMPBa4LD
SqFrwozMSZu+cFDnxrU5kEx9SopZRQA=
=897V
-----END PGP SIGNATURE-----

--FP1s9Lrv1CHcNv+X--

