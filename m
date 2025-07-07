Return-Path: <linux-wireless+bounces-24873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F42AFAC60
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9BE172FDF
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 07:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167728726B;
	Mon,  7 Jul 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XJ1k3OMw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4228724B;
	Mon,  7 Jul 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871545; cv=none; b=ZE5+2UVl3RlIgezX1d1AFOdSLox+vfGfd+cedZ4EucEhQ5bmt1vNTDm9RIW6d/nCG1FQXDWzJQUok1NJ/Vt4T/21QGzHy4avvr89VYLBBjGIyReH5+xqrBeKH4+yEVS10U9ftlSpMCGzasdgC1WadZvg99ySWevI3JPsiOzfPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871545; c=relaxed/simple;
	bh=q5FZ/FivWBaXWG6gVD9nT0Wg6DMs8v6iPl7pHoRyQJk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kfUgUKsHUglMEpt9lLPjoZk1GkV3Axts+B2krINYn5r4q99hYeCQQ5j+YrvHDAQkPRf+bVE8uc7qGQHPaztq3mJQmxiIg1BgO/8ZFhIA8Tzhs+NNPeIfVx5CQLlWqbKfqTc6mfI1UJAC4Q2OE6H6H/4WtNYLpE77ffHtD1JhUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XJ1k3OMw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 322B11FCF0;
	Mon,  7 Jul 2025 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751871534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2ZYTC0qX+ptd1Xz5KDmZ2eEoJyxUi5525heb7B18Aw=;
	b=XJ1k3OMw1IieO1jf105DCvr2FDPmsgJlqGpSGWJmL575MSncbwGw8q8xZbKZdujzPitZLa
	YpQ5L3FUwnG4Y+A0eWIvQlJVrIzdK9+jkyz/jsY31j9K61abpJfdJKJfGNvfab3EVKA9fB
	Fd4CpncLWi1od2mCdmUNyUQk4tPCj9AY0cux/yECUsWFSDiwTe7BUgvCZ3dX9xox9lqYKa
	qb8YZuqY/vTaJ7O7lBzmCTOL1CIfRvSRNhHqcA8oZd9C+zxejW+sjEQMQl0khCZjw2AWkR
	5/V5gweCS1QypvpXGu0sNAqintg75CubhwSE9Svc+xOP5VCxmuVX/oQJKYQVvQ==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 08:58:53 +0200
Message-Id: <DB5MMOAEFZZU.5TK1BDNOTFEO@bootlin.com>
Cc: <linux-kernel@vger.kernel.org>, <ajay.kathat@microchip.com>,
 <claudiu.beznea@tuxon.dev>, <marex@denx.de>, <kvalo@kernel.org>,
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH] wilc1000: replace deprecated strcpy() with strscpy()
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?q?Miguel_Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
 <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250705134810.197494-1-miguelgarciaroman8@gmail.com>
In-Reply-To: <20250705134810.197494-1-miguelgarciaroman8@gmail.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefuddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehmihhguhgvlhhgrghrtghirghrohhmrghnkeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrjhgrhidrkhgrthhhr
 ghtsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehkvhgrlhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hi,

On Sat Jul 5, 2025 at 3:48 PM CEST, Miguel Garc=C3=ADa wrote:
> strcpy() is deprecated for NUL-terminated strings.  Replace the single
> instance in wilc1000 netdev setup with strscpy(), which guarantees
> NUL-termination and prevents overflow.
>
> ndev->name is a fixed-size buffer (IFNAMSIZ, 16 bytes).
>
> Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>

LGTM, thanks for the update

Reviewed-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

> ---
>  drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/n=
et/wireless/microchip/wilc1000/netdev.c
> index af298021e050..8f4d11e1a2a6 100644
> --- a/drivers/net/wireless/microchip/wilc1000/netdev.c
> +++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
> @@ -960,7 +960,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl=
, const char *name,
> =20
>  	vif =3D netdev_priv(ndev);
>  	ndev->ieee80211_ptr =3D &vif->priv.wdev;
> -	strcpy(ndev->name, name);
> +	strscpy(ndev->name, name, sizeof(ndev->name));
>  	vif->wilc =3D wl;
>  	vif->ndev =3D ndev;
>  	ndev->ml_priv =3D vif;




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


